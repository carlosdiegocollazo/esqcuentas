let Usuario = {
	
	getRecordById: async function (tabla, idTabla, id){
		let sql 		= `
							SELECT *
							FROM ${tabla}
							WHERE
							${idTabla} = ${id}
						`
		let response 	= {error: "No se encontraron registros"}
		let res 		= await conn.query(sql);
		if (res.code) {
	 		response 	= {error: "Error en consulta SQL"};
	 	}else if (res.length>0) {
			response 	= res[0];
			}
		return response; 
	},

	usuarioLogin: async function(usuario, password){
		let sql =  `
				SELECT * 
				FROM personas 
				WHERE personas.email = '${usuario}'
				&&
				personas.pass =MD5('${password}')
				&&
				personas.activo = 1
			`
		let response = {error: "Usuario / Contraseña incorrectos"}
		let usuarios = await conn.query(sql);
		try {
			if (usuarios.length>0) {
				let usuario 	= usuarios[0];
				const payload 	= {usuario:  usuario};
				const token 	= jwt.sign(payload, conn.llave, {expiresIn: 18000});
				response 		= {response: usuario,token: token};
			}
		} catch(e) {
			console.log(e);
			}
		return response;
	},

	obtenerUsuarios: async function(){
		let sql 		= `
							SELECT * FROM personas
							WHERE personas.activo = 1
						`
		let response 	= {error: "No se encontraron usuarios"}
		let resultado 	= await conn.query(sql);
		if (resultado.code) {
	 		response 	= {error: "Error en consulta SQL"};
	 	}else if (resultado.length>0) {
			response 	= {response: resultado}
			}
		return response;
	},

	obtenerUsuarioPorId: async function (id){
	 let sql = `
	  			SELECT * FROM personas
	  			WHERE 
	  			personas.idper = '${id}' 
	  			&& personas.activo = 1
	 		`
	 let usuarios 	= []
	 let response 	= {error: `No existe el usuario con ID: ${id}`}
	 usuarios 		= await conn.query(sql)
	 if (usuarios.code) {
	 	response 	= {error: "Error en consulta SQL"};
	 }else if (usuarios.length > 0) {
	 	response 	= {response: usuarios[0]}
	 }
	 return response;
	},

	obtenerUsuarioPorEmail: async function (mail){
	 let sql = `
	  			SELECT personas.idper 
	  			FROM personas
	  			WHERE 
	  			personas.email = '${mail}'
	 		`
	 let usuarios 	= []
	 let response 	= {error: `No existe el usuario con mail : ${mail}`}
	 usuarios 		= await conn.query(sql)
	 if (usuarios.code) {
	 	response 	= {error: "Error en consulta SQL"};
	 }else if (usuarios.length > 0) {
	 	response 	= {response: usuarios[0]}
	 }
	 return response;
	},

	ingresarUsuario: async function(usuario){
		let sql = `
					INSERT INTO personas
					  		(
							email,
							nombre,
							apellido,
							razon,
							rutced,
							pass,
							fechaingreso,
							telefono,
							direccion,
							proveedor,
							moneda,
							seguridad,
							saldoinicial,
							retorno,
							retactivo,
							observaciones,
							activo
							 )
		  			VALUES
		  					(
							'${usuario.email}',
							MD5('${usuario.pass}'),
							'${usuario.nombre}',
							'${usuario.apellido}',
							'${usuario.razon}',
							'${usuario.rutced}',
							'${usuario.fechaingreso}',
							'${usuario.telefono}',
							'${usuario.direccion}',
							'${usuario.proveedor}',
							'${usuario.moneda}',
							'${usuario.seguridad}',
							'${usuario.saldoinicial}',
							'${usuario.retorno}',
							'${usuario.retactivo}',
							'${usuario.observaciones}',
							'${usuario.activo}'
							)
				`
		let response 		= {error: "No se pudo crear el usuario"}
		let mail 			= usuario.email;
		let existeUsuario 	= await this.obtenerUsuarioPorEmail(mail);
		if (existeUsuario.error) {
			try {
				let resultado 	= await conn.query(sql);
				if (resultado.code) {
		 			response 	= {error: "Error en consulta SQL"};
		 		}else if (resultado.insertId) {
					response 	= {response: "Usuario creado correctamente"}
				}
			} catch(error) {
				console.log(error);
				}
		}else {
			response 			= {error: `Ya existe usuario con email : ${mail}`}
			}
		return response;
	},

	actualizarUsuario: async function(usuario, id){
		let sql 		= `
							UPDATE personas 
							SET (
										email,
										pass,
										nombre,
										apellido,
										razon,
										rutced,
										fechaingreso,
										telefono,
										direccion,
										proveedor,
										moneda,
										seguridad,
										saldoinicial,
										retorno,
										retactivo,
										observaciones,
										activo
							 	)

										email 			= '${usuario.email}',
										pas 			= MD5('${usuario.pass}'),
										nombre 			= '${usuario.nombre}',
										apellido 		= '${usuario.apellido}',
										razon 			= '${usuario.razon}',
										rutced			= '${usuario.rutced}',	
										fechaingreso 	= '${usuario.fechaingreso}',
										telefono	 	= '${usuario.telefono}',
										direccion	 	= '${usuario.direccion}',
										proveedor	 	= '${usuario.proveedor}',
										moneda 			= '${usuario.moneda}',
										seguridad 		= '${usuario.seguridad}',
										saldoinicial 	= '${usuario.sadoinicial}',
										retorno			= '${usuario.retorno},
										retornoactivo 	= '${usuario.retornoactivo}',
										observaciones 	= '${usuario.observaciones}',
										activo 			= '${usuario.activo}'
							WHERE
							personas.idper = '${id}'
						`
		let response 		= {error: "No se pudo actualizar usuario"}
		let existeUsuario 	= await this.obtenerUsuarioPorId(id);
		if (!existeUsuario.error) {
			let resultado 	= await conn.query(sql);
			if (resultado.code) {
	 			response 	= {error: "Error en consulta SQL"};
	 		}else if (resultado.affectedRows>0) {
				response 	= {response: "Usuario actualizado correctamente"}
			}
		}else{
			response 		= {error: `No existe usuario con Id: ${id}`}
			}
		return response;
	},	

	eliminarUsuario: async function(id){
		let sql 		= `
							UPDATE personas 
							SET 
							activo = 0 
							WHERE
							personas.idper = '${id}'
						`
		let response 			= {error: "No se pudo eliminar usuario"}
		let existeUsuario 		= await this.obtenerUsuarioPorId(id);
		if (!existeUsuario.error) {
			let resultado 		= await conn.query(sql);
			if (resultado.code) {
	 			response 		= {error: "Error en consulta SQL"};
	 		}else if (resultado.affectedRows>0) {
					response 	= {response: "Usuario eliminado correctamente"}
				}
		}else {
			response 			= {error: `No existe usuario con Id: ${id}`}
			}
		return response;
	},

}

module.exports = Usuario;