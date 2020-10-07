<%@ page import="models.Specie"%>
<%@ page import="utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>Administração</title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <script src="https://cdn.jsdelivr.net/npm/feather-icons/dist/feather.min.js"></script>

		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">

        <link rel="stylesheet" href="./assets/css/style.css" />

    </head>

    <body>
    
    	<script>
    		function showMessage(){
	    		Swal.fire({
	    		  position: 'top-end',
	    		  icon: 'success',
	    		  title: 'Your work has been saved',
	    		  showConfirmButton: false,
	    		  timer: 1500
	    		});
    		}
    		
    	</script>
    
    
    	<%
    		
	    	if(session.getAttribute("username") == null) {
				response.sendRedirect("home.jsp");
			}
    	
		   	if(request.getParameter("id") != null){
				
				int id = Integer.parseInt(request.getParameter("id"));
				
				Specie specie = new Specie(id, "", "", "", "", "", "", "", "", "", "", "");
		
				specie.deleteById(id);
				
				response.sendRedirect("species-admin.jsp");
				
			}
    	
    		if(request.getParameter("specie-id") != null) {
    		
    			String id = request.getParameter("specie-id");
    			String commonName = request.getParameter("specie-commonName");
    			String latinName = request.getParameter("specie-latinName");
    			String kingdom = request.getParameter("specie-kingdom");
    			String division = request.getParameter("specie-division");
    			String classSpecie = request.getParameter("specie-class");
    			String orderSpecie = request.getParameter("specie-order");
    			String family = request.getParameter("specie-family");
    			String genus = request.getParameter("specie-genus");
    			String species = request.getParameter("specie-species");
    			String plantType = request.getParameter("specie-plantType");
    			String file = request.getParameter("specie-file");
    			
    			System.out.println(commonName);
    			System.out.println(latinName);
    			System.out.println(kingdom);
    			System.out.println(division);
    			System.out.println(classSpecie);
    			System.out.println(orderSpecie);
    			System.out.println(family);
    			System.out.println(genus);
    			System.out.println(species);
    			System.out.println(plantType);
    			System.out.println(file);
    			
    			Specie specie = new Specie(Integer.parseInt(id), commonName, latinName, kingdom, division, classSpecie, orderSpecie, family, genus, species, plantType, file);
    			
    			specie.save();
    		}
    			
    		Specie specie = new Specie(0, "", "", "", "", "", "", "", "", "", "", "");
    		
    		String species = specie.listAll();

		%>
    
        <div id="admin">
            <nav>
                <ul>
                    <li><p>Administração</p></li>
                    <li class="right"><a href="home.jsp"><i data-feather="log-out"></i></a></li>
                </ul>
            </nav>

            <div id="sidenav" class="sidenav">
                <a id="users" href="admin.jsp">Usuários</a>
                <a id="species" class="active" href="#species">Espécies</a>
            </div>

            <div class="main">
                <div class="content">

                    <div id="species-panel">
                        <div class="header">
                            <h2 class="title">Informações - Espécies</h2>
                        </div>
                        <div>
                            <table>
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>CommonName</th>
                                        <th>LatinName</th>
                                        <th>Kingdom</th>
                                        <th>Division</th>
                                        <th>Class</th>
                                        <th>Order</th>
                                        <th>Family</th>
                                        <th>Genus</th>
                                        <th>Species</th>
                                        <th>PlantType</th>
                                        <th>Ações</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                    <%= species %>
                                    
                                </tbody>
                            </table>
                            <span class="pagination">
                                <a class="active" href="">1</a>
                                <a class="" href="">2</a>
                                <a class="" href="">3</a>
                                <a class="" href="">4</a>
                            </span>
                        </div>

                        <div id="specie-form" class="form">
                            <h3>Formulário</h3>
                            <form class="" method="POST" action="">
                            
                            	<input type="hidden" id="specie-id" name="specie-id" value="0"/>
                            
                                <label for="specie-commonName">Nome comum
                                    <input type="text" id="specie-commonName" name="specie-commonName" required/>
                                </label>
                                
                                <label for="specie-latinName">Nome Latin
                                    <input type="text" id="specie-latinName" name="specie-latinName" required />
                                </label>

                                <label for="specie-kingdom">Reino
                                    <input type="text" id="specie-kingdom" name="specie-kingdom" required />
                                </label>

                                <label for="specie-division">Divisão
                                    <input type="text" id="specie-division" name="specie-division" required />
                                </label>

                                <label for="specie-class">Classe
                                    <input type="text" id="specie-class" name="specie-class" required />
                                </label>

                                <label for="specie-order">Ordem
                                    <input type="text" id="specie-order" name="specie-order" required />
                                </label>

                                <label for="specie-family">Família
                                    <input type="text" id="specie-family" name="specie-family" required />
                                </label>

                                <label for="specie-genus">Genus
                                    <input type="text" id="specie-genus" name="specie-genus" required />
                                </label>

                                <label for="specie-species">Espécie
                                    <input type="text" id="specie-species" name="specie-species" required value="/"/>
                                </label>

                                <label for="specie-plantType">Tipo de Planta
                                    <input type="text" id="specie-plantType" name="specie-plantType" required value="/" />
                                </label>

								<label for="specie-file">Arquivo
                                    <input type="text" id="specie-file" name="specie-file" required/>
                                </label>

                                <!-- <label for="specie-file">Arquivo
                                    <input type="file" id="specie-file" name="specie-file" required/>
                                </label> -->

                                <button class="success" type="submit">Enviar</button>
                                <button class="danger" type="reset">Cancelar</button>
                            </form>
                        </div>
                    </div>

                    <div style="display: none;" class="" id="teste1-panel"></div>


                    <div style="display: none;" class="" id="teste2-panel"></div>


                </div>
            </div>
        </div>
        
        <script>
            feather.replace();

            let sidenav = document.querySelector('#sidenav');

            // console.log(sidenav);

            sidenav.addEventListener('click', (event) => {
                // console.log(sidenav.children);

                let idAux = document.getElementById(event.target.id);

                if(idAux.id === "sidenav"){
                    return;
                }

                for(let i=0; i<sidenav.children.length; i++){
                    // console.log(sidenav.children[i]);
                    if(sidenav.children[i].className){
                        sidenav.children[i].className = "";
                        document.getElementById(`${sidenav.children[i].id}-panel`).style.display = "none";
                    }
                }
                
                idAux.classList.add('active');
                document.getElementById(`${idAux.id}-panel`).style.display = "";

            });


          </script>
    </body>

</html>