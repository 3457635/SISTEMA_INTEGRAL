Public Class ContraresiboCaja
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Dim cliente = Request.Params("cliente")

            lblFecha.Text = StrConv(Now.AddHours(-7).ToString("D"), VbStrConv.ProperCase)

            Dim cliente_nombre = (From consulta In db.datos_facturacions
                        Where consulta.id_empresa = cliente
                        Select consulta.razon_social).FirstOrDefault()

            lblCliente.Text = cliente_nombre

            Dim lote = ultimoLote()
            lblLote.Text = String.Format("Lote No. {0}", lote)

        End If
    End Sub

    Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton1.Click
        Dim lote = nuevoLote()



        For Each row As GridViewRow In GridView3.Rows
            Dim id_factura = row.Cells(0).Text
            Dim folio = row.Cells(1).Text

            registrarFactura(id_factura, lote)
        Next
    End Sub
    Public Sub registrarFactura(ByVal id_factura As Integer, ByVal lote As Integer)

        Dim buscar_factura = (From consulta In db.facturas
                                          Where consulta.id_factura = id_factura
                                          Select consulta).FirstOrDefault()

        If Not buscar_factura Is Nothing Then
            buscar_factura.Contrarecibo = True

            Dim idDatoFacturacion = buscar_factura.id_dato_facturacion

            registrarFacturasEnLote(id_factura, lote)


            Dim fechaProgramacionCobro = Now.AddDays(obtenerDiasCredito(idDatoFacturacion)).AddHours(-7)
            asignarProgramacionCobro(id_factura, fechaProgramacionCobro)

            Dim buscar_fecha_contra = (From consulta In db.fechas_facturacions
                                         Where consulta.id_factura = id_factura And
                                         consulta.fecha.tipo_fecha = 5
                                         Select consulta.fecha).FirstOrDefault()

            If buscar_fecha_contra Is Nothing Then
                Dim nueva_fecha_contrarecibo As New fecha With {.fecha = Now.AddHours(-7),
                                                                .tipo_fecha = 5}

                Dim fecha_factura As New fechas_facturacion With {.fecha = nueva_fecha_contrarecibo,
                                                                  .id_factura = id_factura}

                db.fechas_facturacions.InsertOnSubmit(fecha_factura)

            Else
                buscar_fecha_contra.fecha = Now.AddHours(-7)
            End If
            db.SubmitChanges()
        End If
    End Sub


    Protected Sub GridView3_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView3.RowDataBound

    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        lblCliente.Text = DropDownList1.SelectedValue
    End Sub
   
End Class