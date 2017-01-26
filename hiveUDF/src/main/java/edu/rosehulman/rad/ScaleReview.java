package edu.rosehulman.rad;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.DoubleWritable;
import org.joda.time.DateTime;
import org.joda.time.Days;

public class ScaleReview extends UDF {
	public DoubleWritable evaluate(double score, String date) throws ParseException {
		final double SCALE_START = 100.0;
		
		if (date == null) {
			return null;
		}
		
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		DateTime reviewDate = new DateTime(format.parse(date));
		DateTime currentDate = new DateTime(new Date());
		
		double daysPassed = Days.daysBetween(reviewDate, currentDate).getDays();
		double scaleFactor = (daysPassed > SCALE_START) ? (double) daysPassed / SCALE_START : 1;
		
		return (scaleFactor == 0) ? new DoubleWritable(score) : new DoubleWritable(score / scaleFactor);
	}
}
