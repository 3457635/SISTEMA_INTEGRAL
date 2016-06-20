Public Class precios_cajas
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click


        Dim buscar_precio = (From consulta In db.precios_cajas
                         Where consulta.id_cliente = ddlCliente.SelectedValue 
                         Select consulta
                         ).FirstOrDefault()


        If buscar_precio Is Nothing Then


            Dim nuevo_precio As New precios_caja With {.id_cliente = ddlCliente.SelectedValue,
                                                                  .id_moneda = ddlMoneda.SelectedValue,
                                                                  .factura_dolares = chkFacturaDolares.Checked,
                                                                  .precioXmes = txbPrecioMensual.Text,
                                                       .precioDiario = txbPrecioDiario.Text
                                                                 }
            db.precios_cajas.InsertOnSubmit(nuevo_precio)
            lblAnuncio.Text = "Se guardó el precio con exito."
        Else
            buscar_precio.precioDiario = txbPrecioDiario.Text
            buscar_precio.id_moneda = ddlMoneda.SelectedValue
            buscar_precio.factura_dolares = chkFacturaDolares.Checked
            buscar_precio.precioXmes = txbPrecioMensual.Text
            buscar_precio.precioDiario = txbPrecioDiario.Text

            lblAnuncio.Text = "Se actualizó el precio con exito."
        End If
        db.SubmitChanges()

    End Sub
    Protected Sub limpiar_formulario()

        txbIdCliente.Text = String.Empty
        txbPrecioDiario.Text = String.Empty
        ddlMoneda.DataBind()
        chkFacturaDolares.Checked = False
        txbPrecioMensual.Text = String.Empty

    End Sub
    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCliente.SelectedIndexChanged
        limpiar_formulario()
        Dim buscar_precio = (From consulta In db.precios_cajas
                          Where consulta.id_cliente = ddlCliente.SelectedValue
                          Select consulta
                          ).FirstOrDefault()

        If Not buscar_precio Is Nothing Then

            txbPrecioMensual.Text = String.Format("{0:c}", buscar_precio.precioXmes)

            txbPrecioDiario.Text = String.Format("{0:c}", buscar_precio.precioDiario)

            chkFacturaDolares.Checked = buscar_precio.factura_dolares
            ddlMoneda.SelectedValue = buscar_precio.id_moneda
            txbIdCliente.Text = buscar_precio.id_precio_caja

        End If

        lblAnuncio.Text = String.Empty
    End Sub

   
End Class