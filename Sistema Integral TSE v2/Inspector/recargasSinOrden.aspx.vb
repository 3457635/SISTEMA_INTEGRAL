Public Class recargasSinOrden
    Inherits System.Web.UI.Page
    Dim proxy As New wcfRef1.Service1Client()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ddlMes.SelectedValue = Now.AddHours(-7).Month
            txbAño.Text = Now.AddHours(-7).Year
        End If
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim r As New wcfRef1.recargas_combustible()
        Dim responsable = User.Identity.Name
        Dim tipoRecarga = 0

        Dim buscarEquipo = proxy.buscarEquipoPorId(ddlEquipo.SelectedValue)

        If Not buscarEquipo Is Nothing Then
            tipoRecarga = buscarEquipo.idUso
        End If


        r.id_chofer = ddlChofer.SelectedValue
        r.id_equipo = ddlEquipo.SelectedValue
        r.ticket = txbTicket.Text
        r.idUso = tipoRecarga
        Dim monto = 0
        If IsNumeric(txbMonto.Text) Then
            monto = txbMonto.Text
        End If
        r.monto = monto

        r.id_lugar = ddlLugar.SelectedValue


        Dim odometro = 0
        If IsNumeric(txbOdometro.Text) Then
            odometro = txbOdometro.Text
        End If
        r.odometro = odometro

        Dim litros = 0
        If IsNumeric(txbLitros.Text) Then
            litros = txbLitros.Text
        End If
        r.lts = litros

        r.recargaSinOrden = True
        r.responsable = responsable

       

        r.fechaRecarga = String.Format("{0} {1}", txbFecha.Text, txbHora.Text)

        Try
            Dim nuevarRecarga = proxy.crearRecargaCombustible(r)
        Catch ex As Exception
            lblMensaje.Text = ex.Message
        End Try


        lblMensaje.Text = "Listo!"


        grdRecargas.DataBind()
    End Sub

    Protected Sub btnConsultar_Click(sender As Object, e As EventArgs) Handles btnConsultar.Click
        sdsRecargas.SelectParameters("mes").DefaultValue = ddlMes.SelectedValue
        sdsRecargas.SelectParameters("ano").DefaultValue = txbAño.Text

        If ddlUnidadConsulta.SelectedValue <> 0 Then
            sdsRecargas.SelectParameters("idEquipo").DefaultValue = ddlUnidadConsulta.SelectedValue
        Else
            sdsRecargas.SelectParameters("idEquipo").DefaultValue = Nothing
        End If

    End Sub

    Protected Sub ddlUnidadConsulta_DataBound(sender As Object, e As EventArgs) Handles ddlUnidadConsulta.DataBound
        ddlUnidadConsulta.Items.Add(Crear_item("Todas...", 0))
    End Sub
End Class