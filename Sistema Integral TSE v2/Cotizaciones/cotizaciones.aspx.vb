Public Class cotizaciones
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.AddHours(-7).Year
            sdsCotizaciones.SelectParameters(0).DefaultValue = Nothing
            sdsCotizaciones.SelectParameters(1).DefaultValue = Now.AddHours(-7).Year
        End If


    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim id_cotizacion = e.Row.Cells(0).Text

            Dim buscar_empresa = (From consulta In db.precios
                                 Where consulta.id_cotizacion = id_cotizacion
                                 Select consulta).FirstOrDefault()
            'Busca la fecha en que se vencera la cotizacion 03 nov 2015 jose pallares
            Dim vigencia_Cotizacion = (From consulta In db.cotizaciones
                Where consulta.id_cotizacion = id_cotizacion
                Select consulta.vigencia).FirstOrDefault()

            Dim lblSolicitud As Label = CType(e.Row.FindControl("lblSolicitud"), Label)
            Dim lblRespuesta As Label = CType(e.Row.FindControl("lblRespuesta"), Label)
            Dim lblFechaV As Label = CType(e.Row.FindControl("lblFechaVigencia"), Label)

            Dim imgEstatus As Image = CType(e.Row.FindControl("imgEstatus"), Image)
            Dim sdsPrecios As SqlDataSource = CType(e.Row.FindControl("sdsPrecios"), SqlDataSource)
            Dim lblEmpresa As Label = CType(e.Row.FindControl("lblEmpresa"), Label)

            sdsPrecios.SelectParameters(0).DefaultValue = id_cotizacion
            lblSolicitud.Text = ObtenerFechaSolicitudCotizacion(id_cotizacion)
            lblRespuesta.Text = ObtenerFechaRespuestaCotizacion(id_cotizacion)
            lblFechaV.Text = vigencia_Cotizacion.ToString() ' imprimiento el valor de la vigencia 03 nov 2015

            If Not buscar_empresa Is Nothing Then
                lblEmpresa.Text = buscar_empresa.empresa.nombre
                Select Case buscar_empresa.cotizacione.id_status
                    Case 5
                        imgEstatus.ImageUrl = "~/imagenes/ok.png"
                    Case 6
                        imgEstatus.ImageUrl = "~/imagenes/cancel.png"
                    Case 9
                        imgEstatus.ImageUrl = "~/imagenes/pendiente.png"
                    Case 10
                        imgEstatus.ImageUrl = "~/imagenes/cancel.png"
                End Select
            End If

        End If
    End Sub


    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If (e.CommandName = "modificar") Then
            ' Retrieve the row index stored in the CommandArgument property.
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)

            ' Retrieve the row that contains the button 
            ' from the Rows collection.
            Dim row As GridViewRow = GridView1.Rows(index)

            Response.Redirect("~/cotizaciones/cotizador.aspx?id_cotizacion=" + row.Cells(0).Text)

            ' Add code here to add the item to the shopping cart.

        End If

        If (e.CommandName = "aceptar") Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)

            Dim row As GridViewRow = GridView1.Rows(index)

            Dim id_cotizacion = row.Cells(0).Text

            Dim buscar_cotizacion = (From consulta In db.cotizaciones
                                  Where consulta.id_cotizacion = id_cotizacion
                                  Select consulta).FirstOrDefault()
            If Not buscar_cotizacion Is Nothing Then
                buscar_cotizacion.id_status = 5

                Dim buscar_precios = From consulta In db.precios
                                   Where consulta.id_cotizacion = id_cotizacion
                                   Select consulta

                For Each precio In buscar_precios
                    precio.id_status = 5
                    db.SubmitChanges()
                Next

            End If

        End If
        If (e.CommandName = "rechazar") Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)

            Dim row As GridViewRow = GridView1.Rows(index)

            Dim id_cotizacion = row.Cells(0).Text

            Dim buscar_cotizacion = (From consulta In db.cotizaciones
                                  Where consulta.id_cotizacion = id_cotizacion
                                  Select consulta).FirstOrDefault()
            If Not buscar_cotizacion Is Nothing Then
                buscar_cotizacion.id_status = 10

                Dim buscar_precios = From consulta In db.precios
                                   Where consulta.id_cotizacion = id_cotizacion
                                   Select consulta
                For Each precio In buscar_precios
                    precio.id_status = 10
                    db.SubmitChanges()
                Next
            End If

        End If
        If (e.CommandName = "cancelar") Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)

            Dim row As GridViewRow = GridView1.Rows(index)

            Dim id_cotizacion = row.Cells(0).Text

            Dim buscar_cotizacion = (From consulta In db.cotizaciones
                                  Where consulta.id_cotizacion = id_cotizacion
                                  Select consulta).FirstOrDefault()
            If Not buscar_cotizacion Is Nothing Then
                buscar_cotizacion.id_status = 6

                Dim buscar_precios = From consulta In db.precios
                                   Where consulta.id_cotizacion = id_cotizacion
                                   Select consulta
                For Each precio In buscar_precios
                    precio.id_status = 6
                    db.SubmitChanges()
                Next
            End If
        End If
        GridView1.DataBind()
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        Response.Redirect("~/Cotizaciones/cotizador.aspx")
    End Sub

    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        Dim consecutivo = txbConsecutivo.Text
        Dim ano = txbAno.Text

        sdsCotizaciones.SelectParameters(0).DefaultValue = consecutivo
        sdsCotizaciones.SelectParameters(1).DefaultValue = ano
    End Sub

   
End Class