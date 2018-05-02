package com.Encom.DAO;

import java.sql.*;

public class MysqlDAOFactory extends DAOFactory {
	// Mysql concrete DAO Factory implementation

	public static final String DRIVER = "com.mysql.jdbc.Driver";
	public static final String DBURL = "jdbc:mysql://localhost:3306/"; //"jdbc:mysql://node147325-encom.jelasticlw.com.br:3306/" jdbc:mysql://mysql{node_id}-{your_env_name}.{hoster_domain}/ "jdbc:mysql://localhost:3306/"
	public static final String DBNAME = "encom";
	public static final String DBUSER = "root"; //root
	public static final String DBPASSWORD = "1234"; //"1234"

	// method to create Mysql connections
	public static Connection createConnection() throws SQLException, ClassNotFoundException {

		Connection connection;
		Class.forName(DRIVER);
		connection = DriverManager.getConnection(DBURL + DBNAME, DBUSER, DBPASSWORD);
		return connection;
	}

	@Override
	public ProductDAO getProductDAO() {

		MysqlProductDAO productDAO = MysqlProductDAO.getInstance();
		return productDAO;
	}
	
	@Override
	public UserDAO getUserDAO() {

		MysqlUserDAO userDAO = MysqlUserDAO.getInstance();
		return userDAO;
	}

}
