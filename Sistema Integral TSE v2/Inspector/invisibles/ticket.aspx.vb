Public Partial Class ticket
    Inherits System.Web.UI.Page
    Dim query As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim id_orden = Request.Params("id_orden")
        Dim query As String = "SELECT odometro FROM odometros WHERE tipo_odometro=1 AND id_orden=" + id_orden
        Dim odometro_inicio = SeleccionarRegistro(query)

        query = "SELECT odometro FROM odometros WHERE tipo_odometro=2 AND id_orden=" + id_orden
        Dim odometro_regreso = SeleccionarRegistro(query)

        query = "SELECT SUM(lts) FROM recargas_combustible WHERE id_orden=" + id_orden
        Dim lts = SeleccionarRegistro(query)

        Dim kms As Integer
        Try
            kms = CInt(odometro_regreso) - CInt(odometro_inicio)
            Dim rendimiento = kms / CInt(lts)
            lblRendimiento.Text = CStr(rendimiento)
            lblLiquidación.Text = obtener_gastos_totales(id_orden)

        Catch
            kms = 0

        End Try



    End Sub
    Function obtener_gastos_totales(ByVal id_orden As String) As String
        Dim total As Double
        query = "SELECT sum(cantidad) as info from liquidacion_casetas where id_orden =" + id_orden
        Dim casetas As Double = CDbl(SeleccionarRegistro(query))
        query = "SELECT sum(cantidad) as info from liquidacion_gastos where id_orden =" + id_orden
        Dim otros_gastos As Double = CDbl(SeleccionarRegistro(query))
        query = "SELECT sum(cantidad) as info from recargas_combustible where id_orden =" + id_orden
        Dim recargas As Double = CDbl(SeleccionarRegistro(query))

        total = casetas + otros_gastos + recargas
        Return CStr(total)
    End Function
End Class