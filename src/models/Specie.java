package models;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;

public class Specie {

	private int id;
	private String commonName;
	private String latinName;
	private String kingdom;
	private String division;
	private String classSpecie;
	private String orderSpecie;
	private String family;
	private String genus;
	private String species;
	private String plantType;
	private String photo;
	
	private String tableName  = "species";
	private String fieldsName = "id, commonName, latinName, kingdom, division, class, orderSpecie, family, genus, species, plantType, photo";
	private String fieldKey   = "id";
	 
	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, fieldKey);
	
	public Specie(int id, String commonName, String latinName, String kingdom, String division, String classSpecie, String orderSpecie, String family, String genus, String species, String plantType, String photo) {
		this.setId(id);
		this.setCommonName(commonName);
		this.setLatinName(latinName);
		this.setKingdom(kingdom);
		this.setDivision(division);
		this.setClassSpecie(classSpecie);
		this.setOrderSpecie(orderSpecie);
		this.setFamily(family);
		this.setGenus(genus);
		this.setSpecies(species);
		this.setPlantType(plantType);
		this.setPhoto(photo);
	}

	private String[] toArray() {
		String[] data = new String[] {
			Integer.toString(this.getId()),
			this.getCommonName(),
			this.getLatinName(),
			this.getKingdom(),
			this.getDivision(),
			this.getClassSpecie(),
			this.getOrderSpecie(),
			this.getFamily(),
			this.getGenus(),
			this.getSpecies(),
			this.getPlantType(),
			this.getPhoto()
		};
		return(data);
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCommonName() {
		return commonName;
	}

	public void setCommonName(String commonName) {
		this.commonName = commonName;
	}

	public String getLatinName() {
		return latinName;
	}
	
	public void setLatinName(String latinName) {
		this.latinName = latinName;
	}
	
	public String getKingdom() {
		return kingdom;
	}

	public void setKingdom(String kingdom) {
		this.kingdom = kingdom;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getClassSpecie() {
		return classSpecie;
	}

	public void setClassSpecie(String classSpecie) {
		this.classSpecie = classSpecie;
	}

	public String getOrderSpecie() {
		return orderSpecie;
	}

	public void setOrderSpecie(String orderSpecie) {
		this.orderSpecie = orderSpecie;
	}

	public String getFamily() {
		return family;
	}

	public void setFamily(String family) {
		this.family = family;
	}

	public String getGenus() {
		return genus;
	}

	public void setGenus(String genus) {
		this.genus = genus;
	}

	public String getSpecies() {
		return species;
	}

	public void setSpecies(String species) {
		this.species = species;
	}

	public String getPlantType() {
		return plantType;
	}

	public void setPlantType(String plantType) {
		this.plantType = plantType;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	
	// Métodos para manipulação dos dados no banco de dados
	public void save() {
		this.dbQuery.insert( this.toArray() );
	}
	
	public void update() {
		this.dbQuery.update( this.toArray() );
	}
	
	public void deleteById(int id) {
		
		this.dbQuery.deleteById(id);
	
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
				saida += "<td>"+rs.getString("commonName") + "</td>";
				saida += "<td>"+rs.getString("latinName") + "</td>";
				saida += "<td>"+rs.getString("kingdom") + "</td>";
				saida += "<td>"+rs.getString("division") + "</td>";
				saida += "<td>"+rs.getString("class") + "</td>";
				saida += "<td>"+rs.getString("orderSpecie") + "</td>";
				saida += "<td>"+rs.getString("family") + "</td>";
				saida += "<td>"+rs.getString("genus") + "</td>";
				saida += "<td>"+rs.getString("species") + "</td>";
				saida += "<td>"+rs.getString("plantType") + "</td>";
				saida += "<td class='actions'><a href='?id="+rs.getString("id")+"'><i data-feather='trash-2'></i></a></td>";
				saida += "</tr>";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return (saida);
	}
	
	public String listAllCards() {
		ResultSet rs =  this.dbQuery.select("");
		String saida = "";		
		try {
			while (rs.next()) {
				saida += "<div class='card card-size mb-4'>";
				saida += "<div class='view overlay'>";
				saida += "<img class='card-img-top' src='"+rs.getString("photo")+"' alt='"+rs.getString("commonName")+"'>";
				saida += "<a href='"+rs.getString("id")+"'>";
				saida += "<div class='mask rgba-white-slight'></div>";
				saida += "</a>";
				saida += "</div>";
				saida += "<div class='card-body'>";
				saida += "<h4 class='card-title'>"+rs.getString("commonName")+"</h4>";
				saida += "<p class='card-text'><strong>LatinName: </strong>"+rs.getString("latinName")+"</p>";
				saida += "<p class='card-text'><strong>Kingdom: </strong>"+rs.getString("kingdom")+" </p>";
				saida += "<p class='card-text'><strong>Genus: </strong>"+rs.getString("genus")+" </p>";
				saida += "</div>";
				saida += "</div>";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return (saida);
	}
		
}
