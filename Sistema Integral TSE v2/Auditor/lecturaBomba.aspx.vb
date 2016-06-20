Public Class lecturaBomba
    Inherits System.Web.UI.Page
    Dim proxy As New wcfRef1.Service1Client()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ddlMes.SelectedValue = Now.AddHours(-7).Month
            txbAno.Text = Now.AddHours(-7).Year

            txbFechaLectura.Text = String.Empty
            txbHoraLectura.Text = String.Empty
            txbLectura.Text = String.Empty

        End If
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click

        If String.IsNullOrEmpty(hfldIdLectura.Value) Then

            Dim nuevaLectura As New wcfRef1.lecturasBomba()
            Dim fechaLectura = String.Format("{0} {1}", txbFechaLectura.Text, txbHoraLectura.Text)
            nuevaLectura.fechaLectura = fechaLectura
            nuevaLectura.lectura = txbLectura.Text

            Dim ultimaLectura = proxy.buscarLecturaAnterior(fechaLectura)

            Dim ltsLectura = 0
            Dim diferencia = 0
            Dim cargasRegistradas = 0

            If Not ultimaLectura Is Nothing Then
                cargasRegistradas = proxy.regresarLtsIntPorFechas(ultimaLectura.fechaLectura, nuevaLectura.fechaLectura)
                ltsLectura = nuevaLectura.lectura - ultimaLectura.lectura
                diferencia = ltsLectura - cargasRegistradas
            End If

            nuevaLectura.diferencia = diferencia
            nuevaLectura.litros = ltsLectura
            nuevaLectura.recargas = cargasRegistradas

            Try
                nuevaLectura = proxy.crearLecturaBomba(nuevaLectura)
            Catch ex As Exception
                lblMensaje.Text = ex.Message
            End Try
            lblMensaje.Text = String.Format("Listo! La diferencia es de {0} lts.", diferencia)

        Else
            Dim buscarLectura = proxy.buscarLecturaPorId(hfldIdLectura.Value)

            If Not buscarLectura Is Nothing Then
                Dim fecha = String.Format("{0} {1}", txbFechaLectura.Text, txbHoraLectura.Text)
                Dim lectura = txbLectura.Text

                Dim lecturaAnterior = proxy.buscarLecturaAnterior(fecha)

                If Not lecturaAnterior Is Nothing Then
                    Dim cargasRegistradas = proxy.regresarLtsIntPorFechas(lecturaAnterior.fechaLectura, fecha)
                    Dim ltsLectura = 0
                    Dim diferencia = 0

                    ltsLectura = lectura - lecturaAnterior.lectura
                    diferencia = ltsLectura - cargasRegistradas

                    buscarLectura.fechaLectura = fecha
                    buscarLectura.lectura = lectura
                    buscarLectura.diferencia = diferencia
                    buscarLectura.litros = ltsLectura
                    buscarLectura.recargas = cargasRegistradas

                    Dim exito = False

                    Try
                        exito = proxy.actualizarLecturaBomba(buscarLectura)
                    Catch ex As Exception
                        lblMensaje.Text = ex.Message
                    End Try

                    If exito Then
                        lblMensaje.Text = String.Format("Listo! La diferencia es de {0} lts.", diferencia)
                    Else
                        lblMensaje.Text = String.Format("No se pudo actualizar la lectura, por favor vuelvalo a intentar.")
                    End If

                End If


            End If

        End If

        txbFechaLectura.Text = String.Empty
        txbHoraLectura.Text = String.Empty
        txbLectura.Text = String.Empty

        hfldIdLectura.Value = String.Empty


    End Sub

    Protected Sub btnConsultar_Click(sender As Object, e As EventArgs) Handles btnConsultar.Click

        txbFechaLectura.Text = String.Empty
        txbHoraLectura.Text = String.Empty
        txbLectura.Text = String.Empty

        sdsLecturas.DataBind()
        grdLecturas.DataBind()
    End Sub


    Public Sub recalcular()

    End Sub

    Protected Sub grdLecturas_SelectedIndexChanging(sender As Object, e As GridViewSelectEventArgs) Handles grdLecturas.SelectedIndexChanging

        txbFechaLectura.Text = String.Empty
        txbHoraLectura.Text = String.Empty
        txbLectura.Text = String.Empty

        Dim row As GridViewRow = grdLecturas.Rows(e.NewSelectedIndex)
        hfldIdLectura.Value = row.Cells(1).Text
        txbLectura.Text = row.Cells(3).Text

        If Not String.IsNullOrEmpty(row.Cells(2).Text) Then
            Dim fecha As Date = row.Cells(2).Text
            txbFechaLectura.Text = fecha.Date.ToString("yyyy/MM/dd")
            txbHoraLectura.Text = fecha.ToString("HH:mm")
        End If
        
    End Sub
End Class