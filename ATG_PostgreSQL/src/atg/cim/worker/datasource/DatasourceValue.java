	//

/*** Eclipse Class Decompiler plugin, copyright (c) 2012 Chao Chen (cnfree2000@hotmail.com) ***/
package atg.cim.worker.datasource;

import atg.beans.DynamicBeans;
import atg.beans.PropertyNotFoundException;
import atg.cim.SessionContext;
import atg.cim.persistence.RecentDatasourceList;
import atg.core.util.StringUtils;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Hashtable;
import java.util.List;
import java.util.Properties;

public class DatasourceValue {
	public static String CLASS_VERSION = "$Id: //product/CIM/version/11.1/src/framework/atg/cim/worker/datasource/DatasourceValue.java#2 $$Change: 889849 $";
	private static final String ORACLE_THIN_DEFAULT_XA_CLASS = "oracle.jdbc.xa.client.OracleXADataSource";
	private static final String ORACLE_OCI_DEFAULT_XA_CLASS = "oracle.jdbc.xa.client.OracleXADataSource";
	private static final String DB2_DEFAULT_XA_CLASS = "com.ibm.db2.jcc.DB2XADataSource";
	private static final String MSSQL_DEFAULT_XA_CLASS = "com.microsoft.sqlserver.jdbc.SQLServerXADataSource";
	private static final String MYSQL_DEFAULT_XA_CLASS = "com.mysql.jdbc.jdbc2.optional.MysqlXADataSource";
	private static final String POSTGRES_DEFAULT_XA_CLASS = "org.postgresql.xa.PGXADataSource";
	private static final String ORACLE_THIN_DEFAULT_CLASS = "oracle.jdbc.OracleDriver";
	private static final String ORACLE_OCI_DEFAULT_CLASS = "oracle.jdbc.OracleDriver";
	private static final String DB2_DEFAULT_CLASS = "com.ibm.db2.jcc.DB2Driver";
	private static final String MSSQL_DEFAULT_CLASS = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static final String MYSQL_DEFAULT_CLASS = "com.mysql.jdbc.Driver";
	private static final String SOLID_DEFAULT_CLASS = "solid.jdbc.SolidDriver";
	private static final String INET_DEFAULT_XA_CLASS = "com.inet.tds.DTCDataSource";
	private static final String INET_DEFAULT_CLASS = "com.inet.tds.TdsDriver";
	private static final String POSTGRES_DEFAULT_CLASS = "org.postgresql.Driver";
	private static Hashtable<String, String> mDefaultXAClasses = null;
	private static Hashtable<String, String> mDefaultDriverClasses = null;
	static final String[] ALL_PROPERTY_NAMES;
	String mAlias;
	String mDatabaseType;
	List<String> mDriverPaths;
	String mUrl;
	String mUsername;
	String mPassword;
	String mJndiName;
	String mHostname;
	String mPort;
	String mDatabaseName;

	public DatasourceValue() {
	}

	public DatasourceValue(DatasourceValue pDatasourceValue) {
		if (pDatasourceValue != null) {
			this.mAlias = pDatasourceValue.getAlias();
			this.mUrl = pDatasourceValue.getUrl();
			this.mPassword = pDatasourceValue.getPassword();
			this.mUsername = pDatasourceValue.getUsername();
			this.mHostname = pDatasourceValue.getHostname();
			this.mPort = pDatasourceValue.getPort();
			this.mDatabaseName = pDatasourceValue.getDatabaseName();
			this.mJndiName = pDatasourceValue.getJndiName();
			this.mDatabaseType = pDatasourceValue.getDatabaseType();

			if (pDatasourceValue.getDriverPaths() != null)
				for (String driverPath : pDatasourceValue.getDriverPaths())
					addDriverPath(driverPath);
		}
	}

	public String getAlias() {
		return this.mAlias;
	}

	public void setAlias(String alias) {
		this.mAlias = alias;
	}

	public String getDatabaseType() {
		return this.mDatabaseType;
	}

	public void setDatabaseType(String databaseType) {
		this.mDatabaseType = databaseType;
	}

	public String getUrl() {
		return this.mUrl;
	}

	public void setUrl(String databaseUrl) {
		this.mUrl = databaseUrl;
	}

	public String getNonXAClassName() {
		return ((String) mDefaultDriverClasses.get(getDatabaseType()));
	}

	public String getXAClassName() {
		return ((String) mDefaultXAClasses.get(getDatabaseType()));
	}

	public void setDriverPathsAsString(String pDriverPathsAsString) {
		if ((pDriverPathsAsString == null)
				|| (pDriverPathsAsString.length() == 0)) {
			this.mDriverPaths = null;
		} else {
			String[] paths = StringUtils.splitStringAtCharacterWithQuoting(
					pDriverPathsAsString, ',');

			this.mDriverPaths = new ArrayList(Arrays.asList(paths));
		}
	}

	public String getDriverPathsAsString() {
		if (this.mDriverPaths == null) {
			return null;
		}

		return StringUtils.joinStringsWithQuoting(
				(String[]) this.mDriverPaths.toArray(new String[0]), ',');
	}

	public List<String> getDriverPaths() {
		return this.mDriverPaths;
	}

	public void setDriverPaths(List<String> driverPath) {
		this.mDriverPaths = driverPath;
	}

	public void addDriverPath(String pDriverPath) {
		if (this.mDriverPaths == null) {
			this.mDriverPaths = new ArrayList();
		}
		this.mDriverPaths.add(pDriverPath);
	}

	public String getPassword() {
		return this.mPassword;
	}

	public void setPassword(String password) {
		this.mPassword = password;
	}

	public String getUsername() {
		return this.mUsername;
	}

	public void setUsername(String username) {
		this.mUsername = username;
	}

	public String getJndiName() {
		return this.mJndiName;
	}

	public void setJndiName(String pJndiName) {
		this.mJndiName = pJndiName;
	}

	public String getHostname() {
		return this.mHostname;
	}

	public void setHostname(String pHostname) {
		this.mHostname = pHostname;
	}

	public String getPort() {
		return this.mPort;
	}

	public void setPort(String pPort) {
		this.mPort = pPort;
	}

	public String getDatabaseName() {
		return this.mDatabaseName;
	}

	public void setDatabaseName(String pDatabaseName) {
		this.mDatabaseName = pDatabaseName;
	}

	public String getUserAndUrl() {
		if (getUsername() != null) {
			return getUsername() + "@" + getUrl();
		}
		return getUrl();
	}

	public void copyFrom(DatasourceValue pOther) {
		this.mAlias = pOther.mAlias;
		this.mDatabaseType = pOther.mDatabaseType;
		if (pOther.mDriverPaths == null) {
			this.mDriverPaths = null;
		} else {
			this.mDriverPaths = new ArrayList(pOther.mDriverPaths);
		}
		this.mUrl = pOther.mUrl;
		this.mUsername = pOther.mUsername;
		this.mPassword = pOther.mPassword;
		this.mJndiName = pOther.mJndiName;
		this.mHostname = pOther.mHostname;
		this.mPort = pOther.mPort;
		this.mDatabaseName = pOther.mDatabaseName;
	}

	public Properties getAllPropertiesAsProperties() {
		Properties props = new Properties();

		for (String strPropName : ALL_PROPERTY_NAMES) {
			try {
				String strValue = DynamicBeans.getPropertyValueAsString(this,
						strPropName);

				if (strValue != null)
					props.put(strPropName, strValue);
			} catch (PropertyNotFoundException e) {
				throw new RuntimeException(e);
			}
		}
		return props;
	}

	public void setAllPropertiesAsProperties(Properties pProperties) {
		this.mDriverPaths = null;
		for (String strPropName : ALL_PROPERTY_NAMES) {
			String strValue = pProperties.getProperty(strPropName);
			try {
				DynamicBeans.setPropertyValueFromString(this, strPropName,
						strValue);
			} catch (PropertyNotFoundException e) {
				throw new RuntimeException(e);
			}
		}
		SessionContext.getRecentDatasourceList().addAliasToList(getAlias(),
				this);
	}

	static {
		mDefaultXAClasses = new Hashtable();
		mDefaultXAClasses.put("oraclethin",
				"oracle.jdbc.xa.client.OracleXADataSource");

		mDefaultXAClasses.put("oracleoci",
				"oracle.jdbc.xa.client.OracleXADataSource");

		mDefaultXAClasses.put("db2", "com.ibm.db2.jcc.DB2XADataSource");

		mDefaultXAClasses.put("mssql",
				"com.microsoft.sqlserver.jdbc.SQLServerXADataSource");

		mDefaultXAClasses.put("mysql",
				"com.mysql.jdbc.jdbc2.optional.MysqlXADataSource");

		mDefaultXAClasses.put("solid", "solid.jdbc.SolidDriver");

		mDefaultXAClasses.put("inet", "com.inet.tds.DTCDataSource");
		
		mDefaultXAClasses.put("postgreSQL", POSTGRES_DEFAULT_XA_CLASS);

		mDefaultDriverClasses = new Hashtable();
		mDefaultDriverClasses.put("oraclethin", "oracle.jdbc.OracleDriver");

		mDefaultDriverClasses.put("oracleoci", "oracle.jdbc.OracleDriver");

		mDefaultDriverClasses.put("db2", "com.ibm.db2.jcc.DB2Driver");

		mDefaultDriverClasses.put("mssql",
				"com.microsoft.sqlserver.jdbc.SQLServerDriver");

		mDefaultDriverClasses.put("mysql", "com.mysql.jdbc.Driver");

		mDefaultDriverClasses.put("solid", "solid.jdbc.SolidDriver");

		mDefaultDriverClasses.put("inet", "com.inet.tds.TdsDriver");
		
		mDefaultDriverClasses.put("postgreSQL", POSTGRES_DEFAULT_CLASS);

		ALL_PROPERTY_NAMES = new String[] { "databaseName", "username",
				"password", "url", "jndiName", "hostname", "databaseType",
				"driverPathsAsString", "alias", "port" };
	}
}