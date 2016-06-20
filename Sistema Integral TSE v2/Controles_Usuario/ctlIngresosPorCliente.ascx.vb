Imports System.Data.SqlClient

Public Class ctlIngresosPorCliente
    Inherits System.Web.UI.UserControl

    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.AddHours(-7).Year.ToString()
            total()
            ddlMes.SelectedValue = Now.AddHours(-7).Month

            'Dim queryPesos =
            '    String.Format(
            '"select convert(nvarchar,cast(sum(tabla.total) as money),1) as 'saldo', " & _
            '"tabla.razon_social as nombre " & _
            '"from (" & _
            '"SELECT " & _
            '"distinct Facturas.id_factura," & _
            '"Facturas.total," & _
            '"datos_facturacion.razon_social," & _
            '"Facturas.folio " & _
            '"FROM " & _
            '"Facturas " & _
            '"INNER Join " & _
            '"fechas_facturacion " & _
            '"ON facturas.id_factura = fechas_facturacion.id_factura " & _
            '"INNER Join " & _
            '"fechas " & _
            '"ON " & _
            '"fechas_facturacion.id_fecha = fechas.id_fecha " & _
            '"INNER Join " & _
            '"datos_facturacion " & _
            '"ON " & _
            '"Facturas.id_dato_facturacion = datos_facturacion.id_dato " & _
            '"WHERE " & _
            '"Month(fechas.fecha) = {0} " & _
            '"and " & _
            '"Year(fechas.fecha) = {1} " & _
            '"and " & _
            '"Facturas.folio Is Not NULL " & _
            '"and " & _
            '"Facturas.facturada_dolares = 0 " & _
            '"AND " & _
            '"Facturas.Cancelada = 0 " & _
            '"and " & _
            '"fechas.tipo_fecha = 7 " & _
            '") as tabla " & _
            '"Join " & _
            '"Facturas " & _
            '"as " & _
            '"f_out " & _
            '"on " & _
            '"tabla.id_factura = f_out.id_factura " & _
            '"where(tabla.total) " & _
            '"is not NULL " & _
            '"group by tabla.razon_social " & _
            '"order by saldo ",
            'ddlMes.SelectedValue,
            'txbAno.Text)


            'Dim DBConnection As New SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("tse-erpConnectionString2").ConnectionString)

            'DBConnection.Open()

            'Dim cmd = New SqlCommand(queryPesos, DBConnection)

            'Dim rd = cmd.ExecuteReader

            'Chart1.Series("Series1").Points.DataBind(rd, "Nombre", "Saldo", "")
            'rd.Close()

            'Dim queryDolares =
            '    String.Format(
            '"select convert(nvarchar,cast(sum(tabla.total) as money),1) as 'saldo', " & _
            '"tabla.razon_social as nombre " & _
            '"from (" & _
            '"SELECT " & _
            '"distinct Facturas.id_factura," & _
            '"Facturas.total," & _
            '"datos_facturacion.razon_social," & _
            '"Facturas.folio " & _
            '"FROM " & _
            '"Facturas " & _
            '"INNER Join " & _
            '"fechas_facturacion " & _
            '"ON facturas.id_factura = fechas_facturacion.id_factura " & _
            '"INNER Join " & _
            '"fechas " & _
            '"ON " & _
            '"fechas_facturacion.id_fecha = fechas.id_fecha " & _
            '"INNER Join " & _
            '"datos_facturacion " & _
            '"ON " & _
            '"Facturas.id_dato_facturacion = datos_facturacion.id_dato " & _
            '"WHERE " & _
            '"Month(fechas.fecha) = {0} " & _
            '"and " & _
            '"Year(fechas.fecha) = {1} " & _
            '"and " & _
            '"Facturas.folio Is Not NULL " & _
            '"and " & _
            '"Facturas.facturada_dolares = 0 " & _
            '"AND " & _
            '"Facturas.Cancelada = 0 " & _
            '"and " & _
            '"fechas.tipo_fecha = 6 " & _
            '") as tabla " & _
            '"Join " & _
            '"Facturas " & _
            '"as " & _
            '"f_out " & _
            '"on " & _
            '"tabla.id_factura = f_out.id_factura " & _
            '"where(tabla.total) " & _
            '"is not NULL " & _
            '"group by tabla.razon_social " & _
            '"order by saldo ",
            'ddlMes.SelectedValue,
            'txbAno.Text)

            'cmd = New SqlCommand(queryDolares, DBConnection)
            'rd = cmd.ExecuteReader
            'Chart1.Series("Series2").Points.DataBind(rd, "Nombre", "Saldo", "")
            'rd.Close()

            Chart1.DataBind()
            total()
            total_ano()
        End If
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Chart1.DataBind()
        total()
        total_ano()
    End Sub
    Protected Sub total()
        Dim tot = (From consulta In db.fechas_facturacions
                             Where consulta.factura.total IsNot Nothing And
                             consulta.fecha.fecha.Value.Month = ddlMes.SelectedValue And
            consulta.fecha.fecha.Value.Year = txbAno.Text And
                            consulta.fecha.tipo_fecha = 7 And
                            consulta.factura.Cancelada = False And
                            consulta.factura.facturada_dolares = False
                             Select consulta.factura.total).Sum()
        If Not tot Is Nothing Then
            lblTotal.Text = String.Format("{0:c0}", tot)
        End If
    End Sub
    Protected Sub total_ano()
        Dim tot = (From consulta In db.fechas_facturacions
                             Where consulta.factura.total IsNot Nothing And
        consulta.fecha.fecha.Value.Year = txbAno.Text And
                        consulta.fecha.tipo_fecha = 7 And
                        consulta.factura.Cancelada = False And
                        consulta.factura.facturada_dolares = False
                             Select consulta.factura.total).Sum()
        If Not tot Is Nothing Then
            lblAno.Text = String.Format("{0:c0}", tot)
        End If
    End Sub
End Class