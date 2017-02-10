import java.text.ParseException;

import org.apache.hadoop.hive.ql.exec.UDF;

public class Reduce extends UDF {

	public double evaluate(double s) throws ParseException {
		double reduced = Math.max(s, 20);
		return reduced;
	}

}