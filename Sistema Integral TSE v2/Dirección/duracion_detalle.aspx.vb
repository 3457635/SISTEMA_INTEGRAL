Public Class diasXviaje
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim mes = Request.Params("mes")
        Dim ano = Request.Params("ano")
        Dim rango1 = Request.Params("rango1")
        Dim rango2 = Request.Params("rango2")

        Dim viajes = From consulta In db.fechas_viajes, consulta2 In db.fechas_facturacions, consulta3 In db.facturacions
            Where consulta.id_viaje = consulta3.id_viaje And
            consulta3.id_factura = consulta2.id_factura And
            consulta2.fecha.tipo_fecha = 7 And
            consulta.fecha.fecha.Value.Month = mes And
            consulta.fecha.fecha.Value.Year = ano And
            (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days >= rango1 And
        (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days <= rango2
                       Select orden = consulta.viaje.Ordene.ano.ToString() + "-" + consulta.viaje.Ordene.consecutivo.ToString() + "-" + consulta.viaje.num_viaje.ToString(),
        consulta.viaje.precio.empresa.nombre,
        consulta.viaje.precio.llave_ruta.ruta,
        f_serv = consulta.fecha.fecha,
        f_pago = consulta2.fecha.fecha,
        dias = (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days



        GridView2.DataSource = viajes
        GridView2.DataBind()




    End Sub

   

    


  
End Class