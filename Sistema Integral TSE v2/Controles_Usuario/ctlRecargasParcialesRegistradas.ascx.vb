Public Class ctlRecargasParcialesRegistradas
    Inherits System.Web.UI.UserControl
    Dim proxy As New wcfRef1.Service1Client()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnEliminarParcial_Click(sender As Object, e As EventArgs) Handles btnEliminarParcial.Click
        Dim recargasParciales = proxy.buscarRecargasParcialesPorGrupo(ddlRecargas.SelectedValue)

        Dim lts = 0.0F ''Recargas Combustible
        Dim kms = 0.0F ''Kms de rendmientos

        For Each r In recargasParciales
            Dim idRendimiento = r.idRendimiento
            Dim re = proxy.buscarRendimientoPorId(idRendimiento)
            Dim idEquipoAsignado = re.idEquipoAsignado

            lts = proxy.buscarLtsPorAsignacion(idEquipoAsignado)

            kms = re.kms

            If IsNumeric(lts) Then
                re.lts = lts
            End If

            If (lts > 0) Then
                re.rendimiento1 = kms / lts
            Else
                re.rendimiento1 = 0
            End If
            proxy.actualizarRendimiento(re)

            proxy.borrarRecargaParcial(r)
        Next
        ddlRecargas.DataBind()

    End Sub

    Protected Sub ddlUnidad_DataBound(sender As Object, e As EventArgs) Handles ddlUnidad.DataBound
        ddlUnidad.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub
End Class