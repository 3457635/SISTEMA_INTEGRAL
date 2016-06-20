Public Partial Class Tarifas_Choferes
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlVehiculo.SelectedIndexChanged
        lblAnuncio.Text = ""
        

       

        Dim porVehiculo = (From consulta In db.precios
                       Where consulta.id_empresa = ddlCliente.SelectedValue And
                       consulta.llave_ruta.id_status = 5 And
                       consulta.id_status = 5 And
                       consulta.id_ruta = ddlRuta.SelectedValue And
        consulta.id_tipo_recurso = ddlVehiculo.SelectedValue
                       Select consulta.empresa.nombre,
        consulta.llave_ruta.ruta,
        consulta.tipo_equipo.equipo,
        consulta.id_relacion,
        consulta.tarifa).OrderBy(Function(x) x.ruta)



        GridView1.DataSource = porVehiculo
        GridView1.DataBind()
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        If IsNumeric(txbTarifa.Text) Then
            Dim buscar_precio = From consulta In db.precios
                                  Where consulta.id_empresa = ddlCliente.SelectedValue And
                                  consulta.id_ruta = ddlRuta.SelectedValue
                                  Select consulta.id_relacion

            For Each precio In buscar_precio

            Next
        Else
            lblAnuncio.Text = "Ingrese una tarifa valida."
        End If




    End Sub

    Protected Sub ddlCliente_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCliente.SelectedIndexChanged
        lblAnuncio.Text = ""

       

        txbTarifa.Text = ""

        
    End Sub

    Protected Sub ddlRuta_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlRuta.SelectedIndexChanged
        lblAnuncio.Text = ""
        

        txbTarifa.Text = ""
       
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound

    End Sub
End Class