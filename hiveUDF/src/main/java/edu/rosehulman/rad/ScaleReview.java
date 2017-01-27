package edu.rosehulman.rad;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.hadoop.hive.ql.exec.UDF;
import org.joda.time.DateTime;
import org.joda.time.Years;

public class ScaleReview extends UDF {
	public double evaluate(double score, String date) throws ParseException {
		final double SCALE_START = 1.0;
		
		if (date == null) {
			return -1;
		}
		
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		DateTime reviewDate = new DateTime(format.parse(date));
		DateTime currentDate = new DateTime(new Date());
		
		double yearsPassed = Years.yearsBetween(reviewDate, currentDate).getYears();
		double scaleFactor = (yearsPassed > SCALE_START) ? (double) (yearsPassed - SCALE_START) : 1.0;
		
		return score / scaleFactor;
	}
}
