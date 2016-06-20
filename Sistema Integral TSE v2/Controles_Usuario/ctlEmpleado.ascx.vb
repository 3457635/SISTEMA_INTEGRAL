Public Class ctlPersona
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub

   

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim db As New DataClasses1DataContext()
        Dim primer_nombre = StrConv(txbPrimerNombre.Text, VbStrConv.ProperCase)
        Dim segundo_nombre = StrConv(txbSegundoNombre.Text, VbStrConv.ProperCase)
        Dim apellido_paterno = StrConv(txbApellidoPaterno.Text, VbStrConv.ProperCase)
        Dim apellido_materno = StrConv(txbApellidoMaterno.Text, VbStrConv.ProperCase)

        If txbIdempleado.Text = "" Then

            Dim nueva_persona As New persona With {.primer_nombre = primer_nombre, .segundo_nombre = segundo_nombre, .id_status = 5,
                                                   .apellido_paterno = apellido_paterno, .apellido_materno = apellido_materno}
            Dim nueva_empleado As New empleado With {.id_estadocivil = ddlEstadoCivil.SelectedValue, .persona = nueva_persona, .id_puesto = ddlPuesto.SelectedValue}

            nueva_persona.empleados.Add(nueva_empleado)
            db.personas.InsertOnSubmit(nueva_persona)
            db.SubmitChanges()



        Else
            Dim actualizar_empleado = (From query In db.empleados _
                                                  Where query.id_empleado = txbIdempleado.Text
                                                  Select query).First()
            actualizar_empleado.persona.primer_nombre = primer_nombre
            actualizar_empleado.persona.segundo_nombre = segundo_nombre
            actualizar_empleado.persona.apellido_paterno = apellido_paterno
            actualizar_empleado.persona.apellido_materno = apellido_materno
            actualizar_empleado.id_estadocivil = ddlEstadoCivil.SelectedValue
            actualizar_empleado.id_puesto = ddlPuesto.SelectedValue
            db.SubmitChanges()
        End If
        lblmensaje.Text = "Se guardó la información de " + txbPrimerNombre.Text + " " + txbSegundoNombre.Text
        limpiar_formulario()
        DropDownList1.DataBind()
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        lblmensaje.Text = ""
        limpiar_formulario()
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        lblmensaje.Text = ""
        Dim db As New DataClasses1DataContext()
        Dim q = From query In db.empleados _
                Where query.id_empleado = DropDownList1.SelectedValue
                                    Select query.id_puesto,
                                    query.persona.primer_nombre,
                                    query.persona.segundo_nombre,
                                    query.persona.apellido_paterno,
                                    query.persona.apellido_materno,
                                    query.id_empleado,
                                    query.id_estadocivil,
                                    query.id_persona


        If Not q.ToList.Item(0).primer_nombre Is Nothing Then
            txbPrimerNombre.Text = q.ToList.Item(0).primer_nombre.ToString
        End If

        txbIdempleado.Text = q.ToList.Item(0).id_empleado.ToString

        If Not q.ToList.Item(0).segundo_nombre Is Nothing Then
            txbSegundoNombre.Text = q.ToList.Item(0).segundo_nombre.ToString
        End If
        If Not q.ToList.Item(0).apellido_paterno Is Nothing Then
            txbApellidoPaterno.Text = q.ToList.Item(0).apellido_paterno.ToString
        End If
        If Not q.ToList.Item(0).apellido_materno Is Nothing Then
            txbApellidoMaterno.Text = q.ToList.Item(0).apellido_materno.ToString
        End If
        If Not q.ToList.Item(0).id_estadocivil Is Nothing Then
            ddlEstadoCivil.SelectedValue = q.ToList.Item(0).id_estadocivil.ToString
        End If
        If Not q.ToList.Item(0).id_puesto.ToString Is Nothing Then
            ddlPuesto.SelectedValue = q.ToList.Item(0).id_puesto.ToString
        End If
    End Sub
    Protected Sub limpiar_formulario()
        txbIdempleado.Text = ""
        txbPrimerNombre.Text = ""
        txbSegundoNombre.Text = ""
        txbApellidoPaterno.Text = ""
        txbApellidoMaterno.Text = ""
        DropDownList1.DataBind()
        ddlEstadoCivil.DataBind()
        ddlPuesto.DataBind()
    End Sub

    Protected Sub btnBaja_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBaja.Click
        Dim db As New DataClasses1DataContext()
        If txbIdempleado.Text <> "" Then
            Dim empleado = (From query In db.empleados
                           Where query.id_empleado = txbIdempleado.Text
                           Select query).First()

            empleado.persona.id_status = 6

            db.SubmitChanges()
            lblmensaje.Text = "Se dio de baja a " + txbPrimerNombre.Text + " " + txbApellidoPaterno.Text
            limpiar_formulario()
        End If
        DropDownList1.DataBind()
    End Sub
End Class