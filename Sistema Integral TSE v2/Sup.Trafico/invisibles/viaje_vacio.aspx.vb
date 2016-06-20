Imports System.Data.SqlClient
Partial Public Class viaje_vacio
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then


            Dim id_orden As String = Request.Params("id_orden")
            lblOrden.Text = id_orden
            Dim strConnection As String = ConfigurationManager.ConnectionStrings("tse-erpConnectionString2").ConnectionString

            Dim Query As String = "SELECT     dbo.empleados.id_empleado as info " & _
    "FROM         Ordenes INNER JOIN " & _
                          "viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN " & _
                          "recursos_asignados ON viajes.id_viaje = recursos_asignados.id_viaje INNER JOIN " & _
                          "dbo.empleados ON recursos_asignados.id_empleado = dbo.empleados.id_empleado INNER JOIN " & _
                          "dbo.unidades ON recursos_asignados.id_unidad = dbo.unidades.id_unidad INNER JOIN " & _
                          "dbo.cajas ON recursos_asignados.id_caja = dbo.cajas.id_caja WHERE ordenes.id_orden=" + id_orden
            Dim id_empleado As String = SeleccionarRegistro(Query)

            Query = "SELECT     dbo.unidades.id_unidad as info " & _
    "FROM         Ordenes INNER JOIN " & _
                  "viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN " & _
                  "recursos_asignados ON viajes.id_viaje = recursos_asignados.id_viaje INNER JOIN " & _
                  "dbo.empleados ON recursos_asignados.id_empleado = dbo.empleados.id_empleado INNER JOIN " & _
                  "dbo.unidades ON recursos_asignados.id_unidad = dbo.unidades.id_unidad INNER JOIN " & _
                  "dbo.cajas ON recursos_asignados.id_caja = dbo.cajas.id_caja WHERE ordenes.id_orden=" + id_orden
            Dim id_unidad As String = SeleccionarRegistro(Query)

            Query = "SELECT     dbo.cajas.id_caja as info " & _
    "FROM         Ordenes INNER JOIN " & _
          "viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN " & _
          "recursos_asignados ON viajes.id_viaje = recursos_asignados.id_viaje INNER JOIN " & _
          "dbo.empleados ON recursos_asignados.id_empleado = dbo.empleados.id_empleado INNER JOIN " & _
          "dbo.unidades ON recursos_asignados.id_unidad = dbo.unidades.id_unidad INNER JOIN " & _
          "dbo.cajas ON recursos_asignados.id_caja = dbo.cajas.id_caja WHERE ordenes.id_orden=" + id_orden
            Dim id_caja As String = SeleccionarRegistro(Query)

            Using objConnection As New SqlConnection(strConnection)
                objConnection.Open()
                Query = "SELECT id_empleado, nombre+' '+apellido as chofer FROM empleados WHERE id_status=5 and id_puesto=1 ORDER BY nombre"

                Dim cmd As New SqlCommand(Query, objConnection)

                Dim adapter As New SqlDataAdapter(cmd)
                Dim dt As New DataTable
                adapter.Fill(dt)

                'Dim row As DataRow = dt.NewRow()
                'row("id_empleado") = "34"
                'row("chofer") = "Omar Franco"
                'dt.Rows.Add(row)

                ddlChofer.DataTextField = "chofer"
                ddlChofer.DataValueField = "id_empleado"

                ddlChofer.DataSource = dt
                ddlChofer.DataBind()
                ddlChofer.SelectedValue = id_empleado
            End Using

            Using objConnection As New SqlConnection(strConnection)
                objConnection.Open()
                Query = "SELECT id_caja, codigo FROM cajas ORDER BY codigo"

                Dim cmd As New SqlCommand(Query, objConnection)

                Dim adapter As New SqlDataAdapter(cmd)
                Dim dt As New DataTable
                adapter.Fill(dt)


                ddlCaja.DataTextField = "codigo"
                ddlCaja.DataValueField = "id_caja"

                ddlCaja.DataSource = dt
                ddlCaja.DataBind()
                ddlCaja.SelectedValue = id_caja

            End Using
            Using objConnection As New SqlConnection(strConnection)
                objConnection.Open()
                Query = "SELECT id_unidad, economico FROM unidades ORDER BY economico"

                Dim cmd As New SqlCommand(Query, objConnection)

                Dim adapter As New SqlDataAdapter(cmd)
                Dim dt As New DataTable
                adapter.Fill(dt)


                ddlUnidad.DataTextField = "economico"
                ddlUnidad.DataValueField = "id_unidad"

                ddlUnidad.DataSource = dt
                ddlUnidad.DataBind()
                ddlUnidad.SelectedValue = id_unidad

            End Using

            Query = "SELECT     'ORDEN: '+CONVERT(nvarchar,Ordenes.ano)+'-'+ CONVERT(nvarchar,Ordenes.consecutivo)+'-'+ CONVERT(nvarchar,viajes.num_viaje)+' CLIENTE: '+ dbo.empresas.nombre+' RUTA: '+ CONVERT(nvarchar,dbo.llave_rutas.ruta)+' CHOFER: '+ dbo.empleados.nombre +' '+ dbo.empleados.apellido+' UNIDAD: '+ " & _
                      "dbo.unidades.economico+' CAJA: '+ CONVERT(nvarchar,dbo.cajas.codigo) as info " & _
"FROM         Ordenes INNER JOIN " & _
                      "viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN " & _
                      "precios ON viajes.id_relacion = precios.id_relacion INNER JOIN " & _
                      "dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta AND precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN " & _
                      "recursos_asignados ON viajes.id_viaje = recursos_asignados.id_viaje INNER JOIN " & _
                      "dbo.cajas ON recursos_asignados.id_caja = dbo.cajas.id_caja AND recursos_asignados.id_caja = dbo.cajas.id_caja INNER JOIN " & _
                      "dbo.unidades ON recursos_asignados.id_unidad = dbo.unidades.id_unidad AND recursos_asignados.id_unidad = dbo.unidades.id_unidad INNER JOIN " & _
                      "dbo.empleados ON recursos_asignados.id_empleado = dbo.empleados.id_empleado AND  " & _
                      "recursos_asignados.id_empleado = dbo.empleados.id_empleado INNER JOIN " & _
                      "dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa AND precios.id_empresa = dbo.empresas.id_empresa AND  " & _
                      "precios.id_empresa = dbo.empresas.id_empresa AND precios.id_empresa = dbo.empresas.id_empresa WHERE viajes.id_viaje in (select max(id_viaje) from viajes inner join ordenes on viajes.id_orden=ordenes.id_orden where ordenes.id_orden=" + id_orden + ")"
            Dim info_ultimo_viaje As String = SeleccionarRegistro(Query)
            lblInfo.Text = info_ultimo_viaje
        End If

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim id_orden As String = lblOrden.Text
        Dim id_empleado As String = ddlChofer.SelectedValue
        Dim id_unidad As String = ddlUnidad.SelectedValue
        Dim id_caja As String = ddlCaja.SelectedValue
        Dim query As String = "INSERT INTO viajes_vacios (id_orden,id_empleado,id_unidad,id_caja) VALUES (" + id_orden + "," + id_empleado + "," + id_unidad + "," + id_caja + ")"
        InsertarActualizarRegistro(query)
        query = "UPDATE ordenes SET id_status=7 WHERE id_orden=" + id_orden
        InsertarActualizarRegistro(query)

        lblAnuncio.Text = "Se ha registrado el viaje vacío exitosamente."

    End Sub
End Class