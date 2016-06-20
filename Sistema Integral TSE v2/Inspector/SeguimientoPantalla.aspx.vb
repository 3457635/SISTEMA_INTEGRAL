Imports System.Data.SqlClient


Public Class SeguimientoPantalla
    Inherits System.Web.UI.Page
    Protected WithEvents etiqueta As System.Web.UI.WebControls.Label
    Dim db As New DataClasses1DataContext()
    Dim contador As Integer = 0
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim sdsChofer As SqlDataSource = CType(e.Row.FindControl("sdsChofer"), SqlDataSource)
            Dim id_viaje = e.Row.Cells(0).Text



            sdsChofer.SelectParameters(0).DefaultValue = id_viaje

            Dim sdsUnidad As SqlDataSource = CType(e.Row.FindControl("sdsUnidad"), SqlDataSource)
            sdsUnidad.SelectParameters(0).DefaultValue = id_viaje

            Dim sdsCaja As SqlDataSource = CType(e.Row.FindControl("sdsCaja"), SqlDataSource)
            sdsCaja.SelectParameters(0).DefaultValue = id_viaje

            Dim sdsTrayecto As SqlDataSource = CType(e.Row.FindControl("sdsTrayecto"), SqlDataSource)
            sdsTrayecto.SelectParameters(0).DefaultValue = id_viaje

            Dim lblSeguimiento As Label = CType(e.Row.FindControl("lblSeguimiento"), Label)

            Dim ultimo_seguimiento = (From consulta In db.seguimientos
                                   Where consulta.id_viaje = id_viaje
                                   Order By consulta.id_seguimiento Descending
                                   Select consulta).FirstOrDefault()

            If Not ultimo_seguimiento Is Nothing Then
                Dim id_seguimiento = ultimo_seguimiento.id_seguimiento

                Dim buscar_hora = (From consulta In db.horas
                                Where consulta.id_seguimiento = id_seguimiento
                                Select consulta).FirstOrDefault()

                Dim buscar_ubicacion = (From consulta In db.puntos_predeterminados
                                     Where consulta.id_seguimiento = id_seguimiento
                                     Select consulta).FirstOrDefault()

                If Not buscar_ubicacion Is Nothing And Not buscar_hora Is Nothing Then
                    lblSeguimiento.Text = buscar_ubicacion.ubicacione.ubicacion.ToString() + " //  " + String.Format("{0:R}", buscar_hora.fecha)
                End If

                Dim buscar_arrivos = (From consulta In db.arrivos
                                    Where consulta.id_seguimiento = id_seguimiento
                                    Select consulta).FirstOrDefault()

                If Not buscar_arrivos Is Nothing And Not buscar_hora Is Nothing Then
                    lblSeguimiento.Text = buscar_arrivos.detalle_arrivo.nombre.ToString() + " //  " + String.Format("{0:R}", buscar_hora.fecha)
                End If

                Dim buscar_pausas = (From consulta In db.Pausas
                                   Where consulta.id_seguimiento = id_seguimiento
                                   Select consulta).FirstOrDefault()

                If Not buscar_pausas Is Nothing And Not buscar_hora Is Nothing Then
                    lblSeguimiento.Text = buscar_pausas.tipos_pausa.pausa.ToString() + " //  " + String.Format("{0:R}", buscar_hora.fecha)
                End If


            End If


        End If
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs) Handles Timer1.Tick
        lblActualizacion.Text = Now.AddHours(-7)
        GridView1.DataBind()
        If GridView1.PageIndex < GridView1.PageCount - 1 Then
            GridView1.PageIndex += 1
        Else
            GridView1.PageIndex = 0
        End If



    End Sub
End Class