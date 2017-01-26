package edu.rosehulman.rad;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.joda.time.DateTime;
import org.joda.time.Days;

public class ScaleReview extends UDF {
	public DoubleWritable evaluate(DoubleWritable score, Text date) throws ParseException {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		DateTime reviewDate = new DateTime(df.parse(date.toString()));
		DateTime currentDate = new DateTime(new Date());

		double scaleFactor = (double) Days.daysBetween(reviewDate, currentDate).getDays() / 100.0;
		double scoreValue = score.get();

		return new DoubleWritable(scaleFactor * scoreValue);
	}
}
