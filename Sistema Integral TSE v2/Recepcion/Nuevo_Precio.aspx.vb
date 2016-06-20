Imports System.Data.SqlClient
Partial Public Class Precios
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

  

    

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim id_ruta As Integer = CInt(ddlRuta.SelectedValue)
        Dim id_vehiculo As Integer = CInt(ddlVehiculo.SelectedValue)
        Dim id_moneda As Integer = CInt(ddlMoneda.SelectedValue)

        Dim id_empresa As Integer = CInt(ddlEmpresa.SelectedValue)
        Dim especificacion As String = txbEspecificacion.Text
        Dim precio As Double = Convert.ToDouble(txbPrecio.Text)

        Dim query As String = "INSERT INTO precios (id_ruta,id_tipo_recurso,id_empresa,fecha_alta,id_moneda,especificacion,precio) " & _
        " VALUES (@id_ruta,@id_tipo_recurso,@id_empresa,@fecha,@id_moneda,@especificacion,@precio)"

        Dim strConnection As String = ConfigurationManager.ConnectionStrings("tse-erpConnectionString2").ConnectionString


        Using objConnection As New SqlConnection(strConnection)
            Dim objCommand As New SqlCommand(query, objConnection)
            objCommand.Parameters.Add("@id_ruta", SqlDbType.Int).Value = id_ruta
            objCommand.Parameters.Add("@id_tipo_recurso", SqlDbType.Int).Value = id_vehiculo
            objCommand.Parameters.Add("@id_moneda", SqlDbType.Int).Value = id_moneda
            objCommand.Parameters.Add("@id_empresa", SqlDbType.Int).Value = id_empresa
            objCommand.Parameters.Add("@fecha", SqlDbType.DateTime).Value = DateTime.Now.AddHours(-7)
            objCommand.Parameters.Add("@especificacion", SqlDbType.NVarChar).Value = especificacion
            objCommand.Parameters.Add("@precio", SqlDbType.Float).Value = precio
            objConnection.Open()
            objCommand.ExecuteNonQuery()
        End Using
        ddlRuta.DataBind()
        GridView1.DataBind()

        lblAnuncio.Text = "Se guardó exitosamente."
        txbEspecificacion.Text = ""
        txbPrecio.Text = ""
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        mdlTrayecto.Show()
        lblRuta.Text = ""
    End Sub

    Protected Sub btnCloseChild_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        lblRuta.Text = ""
        mdlTrayecto.Hide()

    End Sub
    Protected Sub btnGuardarOrigen_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarOrigen.Click
        Dim id_ubicacion As String = ddlOrigen.SelectedValue
        Dim id_tipo_arrivo As String = "1"
        Dim ruta As String = ddlOrigen.SelectedItem.ToString

        Dim query As String = "INSERT INTO llave_rutas (ruta) VALUES ('" + ruta + "')"
        InsertarActualizarRegistro(query)

        Dim id_ruta As String = ObtenerLlave("llave_rutas")

        query = "INSERT INTO rutas (id_ubicacion,id_tipo_arrivo,id_ruta) VALUES (" + id_ubicacion + "," + id_tipo_arrivo + "," + id_ruta + ")"
        InsertarActualizarRegistro(query)

        lblIdRuta.Text = id_ruta
        lblRuta.Text = ruta


        mdlTrayecto.Show()

    End Sub

    Protected Sub btnGuardarIntermedio_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarIntermedio.Click

        Dim id_ubicacion As String = ddlIntermedio.SelectedValue
        Dim id_tipo_arrivo As String = "2"

        Dim id_ruta As String = lblIdRuta.Text

        Dim ruta As String = lblRuta.Text + " - " + ddlIntermedio.SelectedItem.ToString

        lblRuta.Text = ruta

        Dim query As String = "UPDATE llave_rutas SET ruta='" + ruta + "' WHERE id_ruta=" + id_ruta
        InsertarActualizarRegistro(query)

        query = "INSERT INTO rutas (id_ubicacion,id_tipo_arrivo,id_ruta) VALUES (" + id_ubicacion + "," + id_tipo_arrivo + "," + id_ruta + ")"
        InsertarActualizarRegistro(query)



        lblIdRuta.Text = id_ruta

        mdlTrayecto.Show()

    End Sub

    Protected Sub btnGuardarDestino_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarDestino.Click
        Dim id_ubicacion As String = ddlDestino.SelectedValue
        Dim id_tipo_arrivo As String = "3"

        Dim id_ruta As String = lblIdRuta.Text

        Dim ruta As String = lblRuta.Text + " - " + ddlDestino.SelectedItem.ToString

        lblRuta.Text = ruta

        Dim query As String = "UPDATE llave_rutas SET ruta='" + ruta + "' WHERE id_ruta=" + id_ruta
        InsertarActualizarRegistro(query)

        query = "INSERT INTO rutas (id_ubicacion,id_tipo_arrivo,id_ruta) VALUES (" + id_ubicacion + "," + id_tipo_arrivo + "," + id_ruta + ")"
        InsertarActualizarRegistro(query)



        lblIdRuta.Text = id_ruta


        ddlRuta.DataBind()
        mdlTrayecto.Show()
    End Sub
End Class