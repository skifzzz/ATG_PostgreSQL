package atg.cim.database;

import java.util.HashMap;
import java.util.Map;

public enum DatabaseType {
	ORACLE_THIN("thin","Oracle Thin"), MS_SQL("ms_sql", "MS SQL"), INET("inet", "iNet MS SQL"), DB2("db2", "DB2"), MY_SQL("my_sql", "MySQL (for development only)"), POSTGRES("postgreSQL", "PostgreSQL 9.3");

	private static Map<String, DatabaseType> sDatabaseTypeNames;
	private String mName;
	private String mDescription;
	
	private DatabaseType(){
	}
	
	private DatabaseType(String pName,String pDescription) {
		this.mName = pName;
		this.mDescription = pDescription;
	}

	public String getName() {
		return this.mName;
	}

	public String getDescription() {
		return this.mDescription;
	}

	public static DatabaseType getByName(String pName) {
		return ((DatabaseType) sDatabaseTypeNames.get(pName));
	}

	public String toString() {
		return this.mName;
	}

	static {
		sDatabaseTypeNames = null;

		sDatabaseTypeNames = new HashMap();
		for (DatabaseType dbType : values())
			sDatabaseTypeNames.put(dbType.mName, dbType);
	}

}
