Public Class CtlSubcuentas
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub txbCuenta_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles txbCuentaPadre.TextChanged
        Dim cuenta As String = txbCuentaPadre.Text
        lblCuenta.Text = cuenta



    End Sub
    Protected Function buscar_subcuenta(ByVal cuenta As Integer) As String
        Dim query As String = "SELECT nombre from subcuentas WHERE id_subcuenta=" + CStr(cuenta)
        Dim nombre As String = SeleccionarRegistro(query)
        Return nombre
    End Function
End Class