Public Class IndicadorKm
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'lunes 7 sep 2015 
        If IsPostBack Then
            Dim dview = CType(sdsKmTotales.Select(DataSourceSelectArguments.Empty), DataView)
            Dim total As Integer
            For Each drv As DataRowView In dview
                total += drv("Kms_Unidad")
            Next
            Label3.Text = "Km recorridos: " + total.ToString() + " Vueltas a la tierra: " + (total / 40075).ToString()
        End If

    End Sub


End Class