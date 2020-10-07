package models;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Usuario {
	
	private int	idUsuario;
	private String name;
	private String email;
	private String birthday;
	private String password;
	private String photo;
	private int idAccessLevel;
	private String token;
	private String createdAt;
	private String updatedAt;
	
	private String tableName  = "users";
	private String fieldsName = "id, name, email, birthday, password, photo, idAccessLevel, token, createdAt, updatedAt";
	private String fieldKey   = "id";
	 
	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, fieldKey);
	 
	public Usuario(int id, String name, String email, String birthday, String password, String photo, int idAccessLevel, String token, String createdAt, String updatedAt) {
		this.setIdUsuario(id);
		this.setName(name);
		this.setEmail(email);
		this.setBirthday(birthday);
		this.setPassword(password);
		this.setPhoto(photo);
		this.setIdAccessLevel(idAccessLevel);
		this.setToken(token);
		this.setCreatedAt(createdAt);
		this.setUpdatedAt(updatedAt);
	}

	private String[] toArray() {
		String[] data = new String[] {
		 Integer.toString(this.getIdUsuario()),
		 this.getName(),
		 this.getEmail(),
		 this.getBirthday(),
		 this.getPassword(),
		 this.getPhoto(),
		 Integer.toString(this.getIdAccessLevel()),
		 this.getToken(),
		 this.getCreatedAt(),
		 this.getUpdatedAt()

		};
		return(data);
	}
	
	
	// Métodos para a manipulação dos atributos da classe
	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	public int getIdAccessLevel() {
		return idAccessLevel;
	}

	public void setIdAccessLevel(int idAccessLevel) {
		this.idAccessLevel = idAccessLevel;
	}
	
	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
	
	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	
	public String getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	// Métodos para manipulação dos dados no banco de dados
	public void save() {
		
		this.dbQuery.insert( this.toArray() );
	
	}
	
	public void update() {
		
		this.dbQuery.update( this.toArray() );
	
	}
	
	public void delete(int id) {
		
		this.dbQuery.deleteById(id);
	
	}
	
	public void setDataToUpdate(String sql) {
		ResultSet rs =  this.dbQuery.select(sql);

		try {
			while (rs.next()) {
				
				setIdUsuario(rs.getInt("id"));
				setName(rs.getString("name"));
				setEmail(rs.getString("email"));
				setBirthday(rs.getString("birthday"));
				setPassword(rs.getString("password"));
				setPhoto(rs.getString("photo"));
				setIdAccessLevel(rs.getInt("idAccessLevel"));
				setToken(rs.getString("token"));
				setCreatedAt(rs.getString("createdAt"));
				setUpdatedAt(rs.getString("updatedAt"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/*private void delete() {
		this.dbQuery.delete( this.toArray() );
	}*/
	
	public String listAll() {
		ResultSet rs =  this.dbQuery.select("");
		String saida = "";		
		try {
			while (rs.next()) {
				saida += "<tr>";
				saida += "<td>"+rs.getString("id") + "</td>";
				saida += "<td>"+rs.getString("name") + "</td>";
				saida += "<td>"+rs.getString("email") + "</td>";
				saida += "<td>"+rs.getString("birthday") + "</td>";
				saida += "<td>"+rs.getInt("idAccessLevel") + "</td>";
				// saida += "<td><select value='0' name='accessLevel' id='accessLevel'><option value='1'>Administrador</option><option value='2' selected>Usuário</option></select></td>";
				saida += "<td>"+rs.getString("createdAt") + "</td>";
				saida += "<td>"+rs.getString("updatedAt") + "</td>";
				saida += "<td class='actions'></a><a href='?id="+rs.getString("id")+"'><i data-feather='trash-2'></i></a></td>";
				saida += "</tr>";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return (saida);
	}
	
	public ResultSet getByEmail(String email) {
		ResultSet rs =  this.dbQuery.select("email = '"+ email +"'");		
		
		return rs;
	}
	
	public int getWhere(String where) {
		
		ResultSet rs = dbQuery.select(where);
		
		try {
			while (rs.next()) {
				return rs.getInt("id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return 0;
				
	}
	
}
