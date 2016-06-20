Public Class WebForm4
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Dim cliente = Request.Params("cliente")




            HyperLink3.Text = StrConv(Now.AddHours(-7).ToString("D"), VbStrConv.ProperCase)

            Dim cliente_nombre = (From consulta In db.datos_facturacions
                        Where consulta.id_empresa = cliente And
                        consulta.idEstatus = 5
                        Select consulta.razon_social).FirstOrDefault()

            HyperLink2.Text = cliente_nombre

            Dim lote = ultimoLote()
            HyperLink1.Text = String.Format("Lote No. {0}", lote)
        End If
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        HyperLink2.Text = DropDownList1.SelectedValue
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click

    End Sub
End Class