#! usr/bin/env python

import sys
from sumy.nlp.tokenizers import Tokenizer
from sumy.parsers.plaintext import PlaintextParser
from sumy.summarizers.lsa import LsaSummarizer as Summarizer
from sumy.nlp.stemmers import Stemmer
from sumy.utils import get_stop_words

LANGUAGE = "english"
SENTENCE_LIMIT = 5


def main():
    # Set up the summarizer.
    stemmer = Stemmer(LANGUAGE)
    summarizer = Summarizer(stemmer)
    summarizer.stop_words = get_stop_words(LANGUAGE)

    for line in sys.stdin:
        try:
            review_id, review_text = line.strip().split("\t")

            # Parse the review_text and get the summary.
            parser = PlaintextParser.from_string(review_text, Tokenizer(LANGUAGE))
            summary = summarizer(parser.document, SENTENCE_LIMIT)

            # Output the summary to stdout.
            output = review_id + "\t"
            for sentence in summary:
                output += str(sentence) + " "

            print(output)
        except Exception as e:
            print(review_id + "\t" + str(e))


if __name__ == "__main__":
    main()
