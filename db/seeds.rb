# Preload random users from Google.

Rails.logger.info "## Add random Google Account "
User.find_or_create_by(uid: "116190515127215562183", name: "Jorge Aviles")
User.find_or_create_by(uid: "106512896250964125154", name: "Carlos Gallardo Soto")
User.find_or_create_by(uid: "104836699739370643031", name: "Silvia Carreño Osvaldes")
User.find_or_create_by(uid: "117786437842462179057", name: "Carola Palma Inostro")
Rails.logger.info "## Finish users."


request_array = [
  [
    "La app de requerimientos necesita pruebas unitarias",
    "<div><div>La app esta en su inicio, pero esta requiriendo pruebas. Las alternativas son:</div><ul><li>Rspec</li><li>Cucumbe</li></ul><p>Quedo atento sus opiniones para la siguiente reunion.</p></div>"
  ],
  [
    "Corregir documentación de aplicación de solicitudes de turno",
    "<p>El programador nuevo esta por llegar, y se necesita que la documentaci&oacute;n de la aplicaci&oacute;n este clara cuando use Rdoc para aprender de ella. Tambien sean claros y en un ingles neutro con los comentarios.</p><p>Tenemos 2 semanas para que llegue el nuevo programador y se apreciaria.</p>"
  ],
  [
    "Usar gema Scenic para generar versionado de vistas de PostgreSQL",
    "<p>En finanzas requieren demasiado usar Excel con la data del servidor, pero esta siendo dificil actualizar cada dia o semana.</p><p>Con la gema es posible crear con Sidekiq workers que actualice las vistas. Ademas, usen el modo materialized que ofrece postgreSQL.</p><p><a href='https://github.com/scenic-views/scenic'>https://github.com/scenic-views/scenic</a></p>"
  ]
]

Rails.logger.info "## Create request."
request_array.each do |request|
  Request.create(
    title: request[0],
    description: request[1],
    user_id: rand(1..4)
  )
end
Rails.logger.info "## Finish request."
