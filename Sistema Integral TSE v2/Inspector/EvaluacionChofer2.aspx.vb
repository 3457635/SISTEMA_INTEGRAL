Public Class EvaluacionChofer2
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txbIdChofer.Text = Request("idChofer")
        txbIdUnidad.Text = Request("idUnidad")

        'llenarEvaluacion()

    End Sub


    'Protected Sub llenarEvaluacion()
    '    Dim idChofer = txbIdChofer.Text
    '    Dim idUnidad = txbIdUnidad.Text

    '    If Not String.IsNullOrEmpty(idUnidad) And Not String.IsNullOrEmpty(idChofer) Then

    '        Dim odometroInicio = obtenerOdometro(idUnidad, 1)
    '        Dim odometroFin = obtenerOdometro(idUnidad, 2)

    '        Dim idOrdenSalida = obtenerOrdenConOdometro(odometroInicio, idUnidad, 1)
    '        Dim idOrdenFin = obtenerOrdenConOdometro(odometroFin, idUnidad, 2)
    '        Dim idEvaluacion = obtenerIdEvaluacion(odometroInicio, 1)


    '        Dim destino = 3


    '        If IsDate(obtenerFechaOrden(idOrdenSalida)) And IsDate(obtenerFechaOrden(idOrdenFin)) Then
    '            Dim fechaSalida As Date = obtenerFechaOrden(idOrdenSalida)
    '            Dim fechaRegreso As Date = obtenerFechaOrden(idOrdenFin)

    '            Obtener_rendimiento(idChofer, idUnidad, odometroInicio, odometroFin)

    '            sdsRuta.SelectParameters(0).DefaultValue = fechaSalida.AddHours(-1).ToString("dd/MM/yyyy HH:mm")
    '            sdsRuta.SelectParameters(1).DefaultValue = fechaRegreso.AddHours(1).ToString("dd/MM/yyyy HH:mm")
    '            sdsRuta.SelectParameters(2).DefaultValue = idUnidad

    '            sqlSalida.SelectParameters(0).DefaultValue = idEvaluacion
    '            'sqlTrayectos.SelectParameters(0).DefaultValue = idOrden
    '            'sqlTrayectos.SelectParameters(1).DefaultValue = idChofer

    '            sqlArribos.SelectParameters(0).DefaultValue = idChofer
    '            sqlArribos.SelectParameters(1).DefaultValue = fechaSalida.AddHours(-1).ToString("dd/MM/yyyy HH:mm")
    '            sqlArribos.SelectParameters(2).DefaultValue = fechaRegreso.AddHours(1).ToString("dd/MM/yyyy HH:mm")
    '        End If
    '    End If

    'End Sub
    'Public Sub Obtener_rendimiento(ByVal idChofer As Integer,
    '                               ByVal idUnidad As Integer,
    '                               ByVal odometroInicio As Integer,
    '                               ByVal odometroFin As Integer)
    '    Dim tabla As New HtmlTable

    '    Dim fila As New HtmlTableRow
    '    Dim celda1 As New HtmlTableCell
    '    Dim celda2 As New HtmlTableCell

    '    Dim buscarChofer = (From consulta In db.empleados
    '               Where consulta.id_empleado = idChofer
    '               Select consulta).FirstOrDefault()

    '    If Not buscarChofer Is Nothing Then
    '        Dim chofer = String.Format("{0} {1}", buscarChofer.persona.primer_nombre, buscarChofer.persona.apellido_paterno)
    '        lblChofer.Text = chofer
    '    End If

    '    Dim trayectoSalida = 1
    '    Dim trayectoRegreso = 2

    '    Dim kms As Integer = 0
    '    If odometroInicio <> 0 And odometroFin <> 0 Then
    '        kms = odometroFin - odometroInicio
    '    End If

    '    Dim idEvaluacion = obtenerIdEvaluacion(odometroInicio, 1)

    '    Dim Recargas = ObtenerRecargas(idEvaluacion)

    '    Dim costo As Decimal = 0
    '    Dim Rendimiento As Decimal = 0

    '    If kms <> 0 And Recargas <> 0 Then
    '        Rendimiento = kms / Recargas
    '    End If

    '    Dim Economico = ObtenerEconomicoUnidad(idUnidad)

    '    celda1.InnerHtml = String.Format("Unidad: <B>{0}</b> Kms: <b>{1}</b> lts: <B>{2}</b>", Economico, kms, Recargas)
    '    celda2.InnerHtml = String.Format("Rendimiento:<B>{0:N2}</b>", Rendimiento)
    '    fila.Cells.Add(celda1)
    '    fila.Cells.Add(celda2)
    '    tabla.Rows.Add(fila)

    '    sdsRecargas.SelectParameters(0).DefaultValue = idChofer
    '    sdsRecargas.SelectParameters(1).DefaultValue = idEvaluacion

    '    sdsRecargasInternas.SelectParameters(0).DefaultValue = idChofer
    '    sdsRecargasInternas.SelectParameters(1).DefaultValue = idEvaluacion

    '    PlaceHolder1.Controls.Add(tabla)

    'End Sub

    'Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
    '    Response.Redirect("~/inspector/Cierre_Viaje2.aspx")
    'End Sub

    'Protected Sub ImageButton3_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnActualizar.Click
    '    llenarEvaluacion()
    'End Sub
End Class