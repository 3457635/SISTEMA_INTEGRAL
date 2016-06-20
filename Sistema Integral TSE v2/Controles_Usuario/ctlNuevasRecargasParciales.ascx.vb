Public Class ctlNuevasRecargasParciales
    Inherits System.Web.UI.UserControl
    Dim proxy As New wcfRef1.Service1Client()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        If RadListBox3.Items.Count = 0 Then
            lblMensaje.Text = String.Format("No hay viajes seleccionados")
            Return
        End If
        
        Dim siguienteGrupo = proxy.siguienteGrupoRecarga()
        Dim idEquipo = ddlUnidad.SelectedValue

        Dim listaViajes(RadListBox3.Items.Count - 1) As Integer

        For Each i In RadListBox3.Items.ToList
            Dim idViaje = i.Value
            listaViajes(i.Index) = idViaje
        Next

        Dim equiposAsignados = proxy.buscarEquipoAsignado(listaViajes, idEquipo)
        Dim rendimientoParcial = proxy.regresarRendimiento(listaViajes, idEquipo)


        If rendimientoParcial <> 0 Then
            For Each ea In equiposAsignados
                Dim buscarRendimiento = proxy.buscarRendimientoPorIdEquipoAsignado(ea)
                If Not buscarRendimiento Is Nothing Then

                    Dim kms = buscarRendimiento.kms

                    ''Ajustamos los litros en base al rendimiento obtenido
                    Dim lts = kms / rendimientoParcial

                    buscarRendimiento.lts = lts
                    buscarRendimiento.rendimiento1 = rendimientoParcial

                    If proxy.actualizarRendimiento(buscarRendimiento) Then
                        Dim nuevaRecargaParcial As New wcfRef1.recargaParcial()
                        nuevaRecargaParcial.idRendimiento = buscarRendimiento.idRendimiento
                        nuevaRecargaParcial.grupo = siguienteGrupo

                        proxy.crearRecargaParcial(nuevaRecargaParcial)
                        lblMensaje.Text = String.Format("Se guardo la recarga parcial #{0}", siguienteGrupo)
                    End If
                End If
            Next
        End If
        sdsRecargasParciales.SelectParameters(0).DefaultValue = siguienteGrupo


    End Sub

    Protected Sub RadListBox1_Transferred(sender As Object, e As Telerik.Web.UI.RadListBoxTransferredEventArgs) Handles RadListBox1.Transferred
        actualizarRendimiento()
    End Sub
    Private Sub actualizarRendimiento()
        Dim listaViajes(RadListBox3.Items.Count - 1) As Integer
        Dim idEquipo = ddlUnidad.SelectedValue

        For Each i In RadListBox3.Items.ToList
            Dim idViaje = i.Value
            listaViajes(i.Index) = idViaje
        Next

        Dim kms = proxy.regresarKms(listaViajes, idEquipo)
        Dim lts = proxy.regresarLts(listaViajes, idEquipo)
        Dim rendimiento = 0.0F
        If lts > 0 Then
            rendimiento = kms / lts
        End If

        ltlIndicador.Text = String.Format("<b>Kms:</b>{0:n0} <b>Lts:</b>{1:n2} <b>Rendimiento:</b>{2:n2}", kms, lts, rendimiento)
    End Sub


    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Response.Redirect(Request.RawUrl)
        'RadListBox3.Items.Clear()
        'RadListBox1.Items.Clear()
        'txbDesde.Text = Nothing
        'txbHasta.Text = Nothing
        'lblMensaje.Text = Nothing
        'Server.Transfer("~/Auditor/recargaParcial.aspx")
    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click

    End Sub
End Class