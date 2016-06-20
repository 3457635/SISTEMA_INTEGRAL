Imports System.Data.SqlClient
Partial Public Class viaje_con_carga
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim id_orden As String = Request.Params("id_orden")
            lblOrden.Text = id_orden
            Dim query As String = "SELECT MAX(num_viaje)as info FROM viajes WHERE id_status<>5 and id_status<>3 and id_orden =" + id_orden
            Dim siguiente_viaje As Integer = CInt(SeleccionarRegistro(query)) + 1
            query = "SELECT CONVERT(nvarchar(4),ano)+'-'+CONVERT(nvarchar(4),consecutivo)  as info FROM ordenes WHERE id_orden=" + id_orden
            Dim nuevo_viaje As String = SeleccionarRegistro(query)
            nuevo_viaje += "-" + CStr(siguiente_viaje)
            lblViaje.Text = nuevo_viaje
        End If
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim id_orden As String = lblOrden.Text

        Dim query As String = "SELECT MAX(num_viaje) as info FROM viajes WHERE id_orden =" + id_orden
        Dim siguiente_viaje As Integer = CInt(SeleccionarRegistro(query)) + 1

        Dim id_contacto As String = ddlContacto.SelectedValue
        Dim id_relacion As String = ddlPrecio.SelectedValue



        Dim fecha As String = ""
        Dim hora As String = txbHora.Text
        If IsDate(hora) Then
            fecha = txbLlegada.Text + " " + hora
        Else
            fecha = txbLlegada.Text + " 23:59"
        End If

        Dim db As New DataClasses1DataContext()

        Dim nuevo_viaje = New viaje With {.id_orden = id_orden, .id_relacion = id_relacion, .id_contacto = id_contacto,
                                          .id_status = 2, .num_viaje = siguiente_viaje, .verificado = False, .facturado = False}
        Dim nueva_fecha = New fecha With {.fecha = CDate(fecha), .tipo_fecha = 1}
        Dim fecha_viaje = New fechas_viaje With {.fecha = nueva_fecha, .viaje = nuevo_viaje}

        db.fechas.InsertOnSubmit(nueva_fecha)
        db.fechas_viajes.InsertOnSubmit(fecha_viaje)
        db.viajes.InsertOnSubmit(nuevo_viaje)

        Dim buscar_orden = (From consulta In db.Ordenes
                         Where consulta.id_orden = id_orden
                         Select consulta).FirstOrDefault()

        If Not buscar_orden Is Nothing Then
            buscar_orden.id_status = 2
        End If


        db.SubmitChanges()
        

        Dim id_viaje As String = ObtenerLlave("viajes")
        

        Response.Redirect("~/Sup.Trafico/invisibles/Asignar_Recursos.aspx?id_viaje=" + id_viaje)


    End Sub

End Class