#! usr/bin/env python
import sys
from sumy.nlp.tokenizers import Tokenizer
from sumy.parsers.plaintext import PlaintextParser
from sumy.summarizers.lsa import LsaSummarizer as Summarizer
from sumy.nlp.stemmers import Stemmer
from sumy.utils import get_stop_words

LANGUAGE = "english"

# Dynamically limit the number of sentence.
# Based on Googling, the average sentence is between 15-20 words. A majority of the words in English are roughly 7 characters with the shorter words appearing in greater frequency.
# So 8*17 = 136. To give room for errors, I rounded up to 200.
CHARACTERS_PER_SENTENCE = 200


def main():
    # Set up the summarizer.
    stemmer = Stemmer(LANGUAGE)
    summarizer = Summarizer(stemmer)
    summarizer.stop_words = get_stop_words(LANGUAGE)

    for line in sys.stdin:
        review_id, review_text = line.strip().split("\t")

        try:
            # Compute a good number of sentence to limit the summary by.
            sentence_limit = max(len(review_text) //
                                 CHARACTERS_PER_SENTENCE, 5)

            # Parse the review_text and get the summary.
            parser = PlaintextParser.from_string(
                review_text, Tokenizer(LANGUAGE))
            summary = summarizer(parser.document, 4)

            # Output the summary to stdout.
            output = review_id + "\t"
            for sentence in summary:
                output += str(sentence) + " "

            print(output)
        except (Exception):
            print(review_id + "\t" + review_text)


if __name__ == "__main__":
    main()
