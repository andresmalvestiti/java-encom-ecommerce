package com.Encom.DAO;

public abstract class DAOFactory {
	// Abstract class DAO Factory

	// List of DAO types supported by the factory
	public static final int MYSQL = 1;
	// public static final int ORACLE = 2;
	// public static final int AZURE = 3;

	// There will be a method for each DAO that can be
	// created. The concrete factories will have to
	// implement these methods.
	public abstract ProductDAO getProductDAO();
	public abstract UserDAO getUserDAO();
	

	public static DAOFactory getDAOFactory(int whichFactory) {

		switch (whichFactory) {
		case MYSQL:
			return new MysqlDAOFactory();
		default:
			return null;
		}
	}
}
