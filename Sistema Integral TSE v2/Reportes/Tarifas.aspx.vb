Public Class Tarifas
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack Then
            If RadioButtonList1.SelectedValue = 0 Then

                Dim nuevo_control_unichofer As UserControl = LoadControl("~/Controles_Usuario/ctlTarifaChofer.ascx")
                PlaceHolder1.Controls.Add(nuevo_control_unichofer)

            Else

                Dim nuevo_control_multichofer As UserControl = LoadControl("~/Controles_Usuario/ctlTarifaMultichofer.ascx")
                PlaceHolder2.Controls.Add(nuevo_control_multichofer)

            End If
        End If

    End Sub

    Protected Sub RadioButtonList1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles RadioButtonList1.SelectedIndexChanged

       

    End Sub
End Class