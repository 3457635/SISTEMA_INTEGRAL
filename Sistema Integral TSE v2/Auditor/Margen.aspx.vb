Public Class Margen
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub

    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim sdsEquipo As SqlDataSource = CType(e.Row.FindControl("sdsEquipo"), SqlDataSource)
            Dim sdsTrayectos As SqlDataSource = CType(e.Row.FindControl("sdsTrayectos"), SqlDataSource)
            Dim idViaje = e.Row.Cells(1).Text
            sdsTrayectos.SelectParameters(0).DefaultValue = idViaje
            sdsEquipo.SelectParameters(0).DefaultValue = idViaje
        End If

    End Sub

    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        If IsDate(txbDesde.Text) And IsDate(txbHasta.Text) Then
            sdsOrdenesDls.SelectParameters(0).DefaultValue = String.Format("{0} 00:00", txbDesde.Text)
            sdsOrdenesDls.SelectParameters(1).DefaultValue = String.Format("{0} 23:59", txbHasta.Text)
            sdsOrdenesMx.SelectParameters(0).DefaultValue = String.Format("{0} 00:00", txbDesde.Text)
            sdsOrdenesMx.SelectParameters(1).DefaultValue = String.Format("{0} 23:59", txbHasta.Text)
        End If

    End Sub

   
    
    Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView2.SelectedIndexChanged
        Dim row As GridViewRow = GridView2.SelectedRow
        Dim idMargen As String = row.Cells(1).Text
        txbIdMargen.Text = idMargen
        sdsViaje.SelectParameters(0).DefaultValue = idMargen
        GridView2.DataBind()

        Dim buscarMargen = (From consulta In db.margens
                         Where consulta.idMargen = idMargen
                         Select consulta).FirstOrDefault()

        If Not buscarMargen Is Nothing Then
            txbCasetas.Text = buscarMargen.casetas
            txbCombustible.Text = buscarMargen.combustible
            txbTarifa.Text = buscarMargen.choferes
        End If

        mdlMargen.Show()

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        actualizarMargen()
    End Sub

    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
        mdlMargen.Hide()
        GridView2.DataBind()
        GridView3.DataBind()
    End Sub

    Protected Sub GridView3_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView3.SelectedIndexChanged
        Dim row As GridViewRow = GridView3.SelectedRow
        Dim idMargen As String = row.Cells(1).Text
        txbIdMargen.Text = idMargen
        sdsViaje.SelectParameters(0).DefaultValue = idMargen
        GridView3.DataBind()

        Dim buscarMargen = (From consulta In db.margens
                         Where consulta.idMargen = idMargen
                         Select consulta).FirstOrDefault()

        If Not buscarMargen Is Nothing Then
            txbCasetas.Text = buscarMargen.casetas
            txbCombustible.Text = buscarMargen.combustible
            txbTarifa.Text = buscarMargen.choferes
        End If

        mdlMargen.Show()
    End Sub
   

    Private Sub actualizarMargen()
        Dim idMargen = txbIdMargen.Text
        Dim costoCasetas As Decimal = 0
        Dim choferTarifa As Decimal = 0
        Dim costoCombustibles As Decimal = 0

        If Not String.IsNullOrEmpty(txbCombustible.Text) Then costoCombustibles = txbCombustible.Text
        If Not String.IsNullOrEmpty(txbCasetas.Text) Then costoCasetas = txbCasetas.Text
        If Not String.IsNullOrEmpty(txbTarifa.Text) Then choferTarifa = txbTarifa.Text

        Dim buscarMargen = (From consulta In db.margens
                                  Where consulta.idMargen = idMargen
                                  Select consulta).FirstOrDefault()

        If Not buscarMargen Is Nothing Then

            Dim idViaje = buscarMargen.idViaje

            Dim buscarPrecio = (From consulta In db.viajes
                             Where consulta.id_viaje = idViaje
                             Select consulta).FirstOrDefault()

            If Not buscarPrecio Is Nothing Then
                Dim precio = buscarPrecio.precio.precio
                If buscarPrecio.precio.id_moneda = 5 Then
                    precio *= 12
                End If

                Dim costos = costoCombustibles + costoCasetas + choferTarifa
                Dim monto As Decimal = precio - costos
                Dim margen As Decimal = monto / precio * 100

                buscarMargen.monto = monto
                buscarMargen.margen = margen
                buscarMargen.combustible = costoCombustibles
                buscarMargen.casetas = costoCasetas
                buscarMargen.choferes = choferTarifa

                db.SubmitChanges()
                GridView4.DataBind()
                
            End If

        End If
    End Sub

    Protected Sub GridView3_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim sdsEquipo As SqlDataSource = CType(e.Row.FindControl("sdsEquipos"), SqlDataSource)
            Dim sdsTrayectos As SqlDataSource = CType(e.Row.FindControl("sdsTrayectos"), SqlDataSource)
            Dim idViaje = e.Row.Cells(1).Text
            sdsEquipo.SelectParameters(0).DefaultValue = idViaje
            sdsTrayectos.SelectParameters(0).DefaultValue = idViaje
        End If
    End Sub
End Class