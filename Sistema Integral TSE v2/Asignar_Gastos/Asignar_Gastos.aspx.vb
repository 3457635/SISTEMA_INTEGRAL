Public Partial Class Asignar_Gastos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardarGastos_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarGastos.Click
        Dim cantidad = txbCantidad.Text

        Dim id_moneda = ddlMoneda.SelectedValue
        Dim id_orden = lblOrden.Text
        Dim query As String = "INSERT INTO viaticos (cantidad,id_moneda,id_orden) VALUES (" + cantidad + ",'" + id_moneda + "'," + id_moneda + "," + id_orden + ")"
        InsertarActualizarRegistro(query)

        txbCantidad.Text = ""

        grdGastos.DataBind()


    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView1.SelectedIndexChanged
        Dim row As GridViewRow = GridView1.SelectedRow
        lblOrden.Text = row.Cells(7).Text
        mdlGastos.Show()


    End Sub

    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
        mdlGastos.Hide()

    End Sub

End Class