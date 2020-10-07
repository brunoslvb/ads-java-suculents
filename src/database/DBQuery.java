package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.swing.JOptionPane;

public class DBQuery {
	
	private Statement 	 statement =  null;
	private String    tableName 	= "";
	private String[]  fieldsName 	= {""};
	private String    fieldKey  	= "";
	private int		  keyFieldIndex = -1;
	
	
	public DBQuery() {
		try {
			this.statement = new DBConnection().getConnection().createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	
	public DBQuery(	String tableName, String fieldsName,  String fieldKey) {
		this.tableName 	= tableName;
		this.fieldsName	= fieldsName.split(",");
		for (int i=0;  i< this.fieldsName.length; i++) {
			this.fieldsName[i] = this.fieldsName[i].trim();
		}
		this.fieldKey   = fieldKey;
		this.keyFieldIndex = whereIsKeyField();
		try {
			this.statement = new DBConnection().getConnection().createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	private int whereIsKeyField() {
		for ( int i =0; i < this.fieldsName.length; i ++ ){
			if( this.fieldsName[i].equals(this.fieldKey) ){
				return(i);
			}
		}
		return(-1);
	}
	
	public ResultSet query(String sql) { // select
		try {
			ResultSet rs = statement.executeQuery(sql);
			return (rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String join (String[] elements, String separator ){
		String out = "";
		for (int i=0; i< elements.length; i++) {
			out +=  elements[i].trim() +  ((i == elements.length-1) ? "" : separator );
		}
		return (out);
	}
	
	public int execute(String sql) { // insert, delete, update
		try {
			int rs = statement.executeUpdate(sql);
			return (rs);
		}catch (SQLException e) {
			System.out.println("\nErro: Verifique o comando ou a dependencia de chave extrangeira!");
		}
		
		return 0;
	}

	public ResultSet select(String where) {
		String sql = "SELECT "+  this.join(this.fieldsName, ", ") + " FROM " + this.tableName;
		sql += (( where!="") ? " WHERE "+ where : "" );
		System.out.print(sql);
		return this.query(sql);
	}
	
	public int insert(String[] values) {
		if ( values.length == this.fieldsName.length){
			String sql = "INSERT INTO "+this.tableName+" ( "+  this.join(this.fieldsName, ", ");
			sql += ") VALUES ('"+join(values, "','")+"')";
			System.out.print(sql);
			return ( this.execute(sql));
		}else{
			System.out.print("O n�mero de valores informados n�o � equivalente aos campos da tabela!");
		}
		

		return 0;
	}
	
	public int delete(String[] values) {
		if (values.length != this.fieldsName.length){
			System.out.println("\n A quantidade de campos � diferente da quantidade de valores!");
			return ( 0 );
		}
		
		String sql = "\nDELETE FROM "+this.tableName+" ";
		if ( this.keyFieldIndex < 0 ){
			return(0);
		}
		sql += "\n WHERE "+ this.fieldKey +" = '"+ values[this.keyFieldIndex] +"'";
		System.out.print( sql );
		return ( this.execute(sql) );
	}
	
	public int deleteById(int id) {
		
		String sql = "DELETE FROM "+this.tableName+" WHERE "+this.fieldKey+" = " + id;
		
		return ( this.execute(sql) );
	}
	
	public int update(String[] values) {
		
		if (values.length != this.fieldsName.length){
			System.out.println("\n A quantidade de campos � diferente da quantidade de valores!");
			return ( 0 );
		}
		
		String sql = "\nUPDATE "+this.tableName+" SET ";
		for( int i=0; i <  values.length; i++){
			sql += "\n\t "+
				this.fieldsName[i] + " = '"+values[i].trim()+"'" 
				+  ((i == values.length-1) ? "" : ", ");
		}
		if ( this.keyFieldIndex < 0 ){
			return(0);
		}
		sql += "\n WHERE "+ this.fieldKey +" = '"+ values[this.keyFieldIndex] +"'";
		System.out.print( sql );
		return ( this.execute(sql) );
	}



}
