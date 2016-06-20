Public Partial Class Rechazos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim id_viaje As String = ObtenerLlave("viajes")
            Dim info_orden As String = InfoSolicitud(id_viaje)
            lblOrden.Text = info_orden
            lblIdViaje.Text = Request.Params("id_viaje")
        End If


    End Sub

    Protected Sub btnGuardarRechazo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarRechazo.Click
        Dim id_tipo_rechazo As String = ddlRechazos.SelectedValue
        Dim descripcion As String = txbDescripcion.Text
        Dim id_viaje As String = lblIdViaje.Text
        Dim strSQL As String = "INSERT INTO rechazos (id_tipo_rechazo,descripcion,id_viaje) VALUES (" + id_tipo_rechazo + ",'" + descripcion + "'," + id_viaje + ");"
        InsertarActualizarRegistro(strSQL)
        


        lblAnuncio.Text = "La información se ha guardado exitosamente."
        btnGuardarRechazo.Enabled = False
        LinkButton1.Visible = True
    End Sub

    
    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LinkButton1.Click
        Response.Redirect("~/Sup.Trafico/Autorizaciones.aspx")
    End Sub
End Class