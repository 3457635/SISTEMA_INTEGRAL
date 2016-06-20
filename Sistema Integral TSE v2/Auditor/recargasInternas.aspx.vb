Public Class recargasInternas
    Inherits System.Web.UI.Page
    Dim litros As Decimal
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    

    Protected Sub ibtnActualizar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizar.Click
        sdsRecargas.SelectParameters("inicio").DefaultValue = String.Format("{0} {1}", txbInicio.Text, txbHoraInicio.Text)
        sdsRecargas.SelectParameters("fin").DefaultValue = String.Format("{0} {1}", txbFin.Text, txbHoraFin.Text)

        If ddlUnidad.SelectedValue <> 0 Then
            sdsRecargas.SelectParameters("idEquipo").DefaultValue = ddlUnidad.SelectedValue
        Else
            sdsRecargas.SelectParameters("idEquipo").DefaultValue = Nothing
        End If



    End Sub

    Protected Sub GridView2_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Me.litros += e.Row.Cells(0).Text
        End If

        If e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(0).Text = String.Format("Total: {0}", Me.litros)
        End If



    End Sub

    Protected Sub ddlUnidad_DataBound(sender As Object, e As EventArgs) Handles ddlUnidad.DataBound
        ddlUnidad.Items.Add(Crear_item("Todas..", Nothing))
    End Sub
End Class