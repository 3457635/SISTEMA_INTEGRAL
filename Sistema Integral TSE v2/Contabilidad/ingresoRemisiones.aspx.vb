Public Class ingresoRemisiones
    Inherits System.Web.UI.Page
    Dim proxy As New wcfRef1.Service1Client()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            sdsRemisionesPendientes.SelectParameters(0).DefaultValue = -1
            sdsRemisionesPendientes.SelectParameters(1).DefaultValue = -1
            txbAno.Text = Now.AddHours(-7).Year
        End If
    End Sub

    Protected Sub ckbViaje_CheckedChanged(sender As Object, e As EventArgs)
        Dim chkResponsable As CheckBox = CType(sender, CheckBox)
        Dim gvrFilaActual As GridViewRow = DirectCast(DirectCast(chkResponsable.Parent, DataControlFieldCell).Parent, GridViewRow)

        Dim total = 0.0F

        For i = 1 To grdViajes.Rows.Count Step 1
            Dim fila = i - 1

            Dim seleccionado = CType(grdViajes.Rows(fila).FindControl("ckbViaje"), CheckBox).Checked()

            If seleccionado Then
                total += grdViajes.Rows(fila).Cells(8).Text
            End If

        Next
        lblTotal.Text = String.Format("{0:c2}", total)
        
        
    End Sub

   
    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        

        For i = 1 To grdViajes.Rows.Count Step 1

            Dim fila = i - 1
            Dim grdRow As GridViewRow = grdViajes.Rows(fila)

            Dim seleccionado = CType(grdViajes.Rows(fila).FindControl("ckbViaje"), CheckBox).Checked()

            If seleccionado Then
                Dim idViaje = grdViajes.Rows(fila).Cells(1).Text
                Dim orden = grdViajes.Rows(fila).Cells(3).Text

                Dim buscarRemision = proxy.buscarRemisionPorIdViaje(idViaje)

                If buscarRemision Is Nothing Then
                    Dim nuevaRemision As New wcfRef1.remisione()
                    nuevaRemision.idViaje = idViaje
                    nuevaRemision.fechaIngreso = txbFechaIngreso.Text
                    nuevaRemision = proxy.crearRemision(nuevaRemision)

                    If Not nuevaRemision Is Nothing Then
                        lblMensaje.Text = String.Format("Listo! ")
                    Else
                        Throw New Exception(String.Format("Ocurrió un error al guardar la orden {0}.", orden))
                    End If
                Else
                    buscarRemision.fechaIngreso = txbFechaIngreso.Text
                    If Not proxy.actualizarRemision(buscarRemision) Then
                        Throw New Exception(String.Format("Ocurrió un error al guardar la orden {0}.", orden))
                    Else
                        lblMensaje.Text = String.Format("Listo! ")
                    End If
                End If

            End If
        Next
        grdViajes.DataBind()
    End Sub

    

    Protected Sub grdViajes_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdViajes.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim sdsFechaIngreso = CType(e.Row.FindControl("sdsFechaIngreso"), SqlDataSource)
            Dim idViaje = e.Row.Cells(1).Text

            sdsFechaIngreso.SelectParameters(0).DefaultValue = idViaje

        End If
    End Sub

    Protected Sub btnConsultar_Click(sender As Object, e As EventArgs) Handles btnConsultar.Click
        sdsRemisionesPendientes.SelectParameters(0).DefaultValue = ddlMes.SelectedValue
        sdsRemisionesPendientes.SelectParameters(1).DefaultValue = txbAno.Text
    End Sub

    Protected Sub lnkPendientes_Click(sender As Object, e As EventArgs) Handles lnkPendientes.Click
        sdsRemisionesPendientes.SelectParameters(0).DefaultValue = -1
        sdsRemisionesPendientes.SelectParameters(1).DefaultValue = -1
    End Sub
End Class