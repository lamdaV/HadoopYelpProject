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
    # test_text = "My first time staying at The LINQ was frustrating. I had to come out to Vegas for my daughters ballet audition. We drove in from Orange County, at first we had a hard time when we found the hotel on the strip figuring out how to get to the parking. It is a smaller hotel in comparison to the ones surrounding it. We went down a back street and found the back of the hotel and saw High Roller. It is impressive, hotel not so much. The hotel was formerly Imperial Palace. They are giving it a facelift I guess. They have painted the outside of the hotel in bright blues and greens. Its like painting old cinder block construction and trying to make it look good. Figuring out where to park was very confusing, eventually we found the parking structure. Parking is free. Before we unloaded all of our luggage and checked in I wanted to make sure there was a room available. It was before the check in time. I called the hotel directly (so I thought). I was placed on hold for over 9 min. and finally someone came on to help me. I asked her if there was a room available to check into now. She said there could be one but I could get to the front desk and it will be gone. Really? She never even asked me for my name or reservation number. I asked her if maybe she should look it up just to double check before I drag all my stuff through the lobby. She sighed and was totally annoyed that I was making her check my reservation. She flat out said no, I could not check in early and if I could it would be $30.00. Rude! I left my luggage in the car and decided to check with the front desk in person. Finding the lobby from the parking garage was a total joke. Half of the hotel was under construction. No real signs directing people how to get to the lobby from the parking garage, myself and other people wondering around confused passing hotel employees smoking never offering to help. Finally found the lobby and front desk. The girl that checked me in was just as rude as the one on the phone. I gave her my name and she pulled up my reservation. She said there were rooms ready! I was so excited, I told her the story about the rude girl on the phone and she didn't give two you know what's about it! She said it would be $40 for early check in. I told her I was quoted $30. She didn't care. I asked her if she could just give it to me for $30. She asked her 'manager' standing behind her at another desk (the one with long black hair) and she said she was not going to give it to me for $30.00. They did give me a $10.00 coupon to one of their restaurants, BFD. So she handed me a room key in an envelope with the numbers 21211 hand written on them and told me the elevator was around the corner. Went back to the car and got the luggage and headed over to the elevators to go to the room I just paid an additional $40 for. I got into the elevator and didn't see a 21st floor?? OK so I went to the 20th floor. No room numbers matched my number. Got back into the elevator and proceeded down each floor. Meanwhile running into other guests with the same problem. They must have been checked in by the same girl. Finally on the 12th floor we found the matching room numbers. Our room was clean, modern and nice for the price. The view from our room was a pool that was under construction. I didn't come to swim so I was ok with that. The hotel is in a very good location, it is basically in the center of the strip. That night we climbed into bed and was pretty happy with the mattress. I was predicting a good nights sleep. NOT! I was woken up by loud music outside and some guy screaming on a microphone. I told myself I am in Vegas, I can not expect to go to sleep at 11:00 PM. But then at 2:00 AM the room next to me was so loud, it sounded like a bunch of guys playing beer pong. they were constantly coming in and out of the room, screaming down the halls. I patiently waited hoping they would stop and finally decided to call the  front desk. the girl was really nice and said she would have security come up right away. Well it took them a good 45 min to an hour to come knock on their door. the next morning I was so ready to leave! I wanted the hell out of this place. I went to the  front desk ready to let this hotel know what I thought of them and was helped by Ashlynne. Let me tell you she is the ONLY reason I gave this review an extra star! She was kind, a good listener, sympathetic, professional, helpful and without me even asking waived my resort fees. I know it was probably all she could have done but the fact that she wanted to make me feel better about my stay meant the world! She was one of the younger employees I had encountered and by far was the most mature and professional. She should be in management at this hotel or the director of training. God knows all the other employees there could take a lesson or two from her playbook. So I gave 1 Star for the location,1 star for the nice room and the last one for Ashlynne for making sure I left with a smile on my face!"

    # Set up the summarizer.
    stemmer = Stemmer(LANGUAGE)
    summarizer = Summarizer(stemmer)
    summarizer.stop_words = get_stop_words(LANGUAGE)

    # Source: https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-python
    # while (True):
    for line in sys.stdin:
        # review_text = sys.stdin.readline().strip()
        review_text = line.strip()


        # Compute a good number of sentence to limit the summary by.
        sentence_limit = max(len(review_text) // CHARACTERS_PER_SENTENCE, 5)

        # Parse the review_text and get the summary.
        parser = PlaintextParser.from_string(review_text, Tokenizer(LANGUAGE))
        # summary = summarizer(parser.document, sentence_limit)

        # Output the summary to stdout.
        # output = []
        # for sentence in summary:
        #     output.append(str(sentence))
        #
        #
        # print("".join(output))
        print(line)



if __name__ == "__main__":
    main()
