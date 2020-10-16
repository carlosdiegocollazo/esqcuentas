let componentemoneda = Vue.component('moneda-component', function (resolve) {
    axios.get('./app/componentes/monedas/vistamonedas.html').then(function (view) {
        resolve({
            template: view.data,
            data: function () {
                return {
                    registro: {
                        monedas: "",
                        divide: 1,
                        activo: 1
                    }

                }
            },
            methods: {
                crearmoneda: function () {
                    let registro = {
                        monedas: this.registro.monedas,
                        divide: this.registro.divide,
                        activo: this.registro.activo
                    }

                    console.log("registro", registro)
                    if (this.registro.moneda !== "") {
                        axios.post(API + 'monedas/new', registro).then((res) => {
                            let resultado = res.data;
                            console.log("resultado", resultado)
                            if (resultado.response) {
                                router.push({ path: '/monedas' });
                            } else {
                                alert(res.data.error);
                            }
                        })
                    } else {
                        alert("Descripcion no puede estar vacia");
                    }
                },
            },
        })
    })
})