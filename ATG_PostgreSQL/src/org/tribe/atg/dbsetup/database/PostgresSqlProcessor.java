package org.tribe.atg.dbsetup.database;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

import atg.core.util.StringUtils;
import atg.dbsetup.database.SQLProcessor;

public class PostgresSqlProcessor extends SQLProcessor {

	@Override
	public String[] processSQL(String paramString) {
		List<String> sqlStrings = new ArrayList<String>();
		String longSql = paramString.trim();

		StringBuffer longBuffer = new StringBuffer(longSql);

		for (String commentKeys : getSQLCommentKeywords()) {
			int commentStartIndex = longBuffer.indexOf(commentKeys);
			while (commentStartIndex >= 0) {
				int newLineIndex = longBuffer.indexOf("\n",
						commentStartIndex + 1);
				if (newLineIndex < 0) {
					newLineIndex = longBuffer.length() - 1;
				}
				longBuffer.delete(commentStartIndex, newLineIndex);
				commentStartIndex = longBuffer.indexOf(commentKeys);
			}

		}

		sqlStrings = Arrays.asList(longBuffer.toString().split(";"));

		for (int i = 0; i < sqlStrings.size(); ++i) {
			int occurs = StringUtils.numOccurrences((String) sqlStrings.get(i),
					'\'');
			if (occurs % 2 <= 0)
				continue;
			sqlStrings.set(i + 1, ((String) sqlStrings.get(i)) + ";"
					+ ((String) sqlStrings.get(i + 1)));
			sqlStrings.set(i, "");
		}

		LinkedList<String> goodSqlStrings = new LinkedList<String>();
		for (String sqlStatement : sqlStrings) {
			if (sqlStatement == null) {
				continue;
			}
			if (sqlStatement.trim().equals("")) {
				continue;
			}

			StringBuffer sqlBuff = new StringBuffer(sqlStatement);
			for (String unnecessarySQL : getUnnecessarySQL()) {
				int removeIndex = sqlStatement.indexOf(unnecessarySQL);
				if (removeIndex >= 0) {
					sqlBuff.delete(removeIndex,
							removeIndex + unnecessarySQL.length());
				}
			}
			String trimedString = sqlBuff.toString().trim();
			if (!(trimedString.equals(""))) {
				goodSqlStrings.add(trimedString);
			}
		}

		return ((String[]) goodSqlStrings.toArray(new String[goodSqlStrings
				.size()]));
	}

}
