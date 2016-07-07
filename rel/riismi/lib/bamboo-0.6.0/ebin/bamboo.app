{application,bamboo,
             [{registered,[]},
              {description,"Straightforward, powerful, and adapter based Elixir email library. Works with Mandrill, Mailgun, SendGrid, SparkPost, in-memory, and test."},
              {vsn,"0.6.0"},
              {modules,['Elixir.Bamboo','Elixir.Bamboo.Adapter',
                        'Elixir.Bamboo.DeliverLaterStrategy',
                        'Elixir.Bamboo.Email',
                        'Elixir.Bamboo.EmailPreviewPlug',
                        'Elixir.Bamboo.EmailPreviewPlug.Helper',
                        'Elixir.Bamboo.EmptyFromAddressError',
                        'Elixir.Bamboo.Formatter',
                        'Elixir.Bamboo.Formatter.BitString',
                        'Elixir.Bamboo.Formatter.List',
                        'Elixir.Bamboo.Formatter.Map',
                        'Elixir.Bamboo.Formatter.Tuple',
                        'Elixir.Bamboo.ImmediateDeliveryStrategy',
                        'Elixir.Bamboo.LocalAdapter','Elixir.Bamboo.Mailer',
                        'Elixir.Bamboo.MailgunAdapter',
                        'Elixir.Bamboo.MailgunAdapter.ApiError',
                        'Elixir.Bamboo.MandrillAdapter',
                        'Elixir.Bamboo.MandrillAdapter.ApiError',
                        'Elixir.Bamboo.MandrillHelper',
                        'Elixir.Bamboo.NilRecipientsError',
                        'Elixir.Bamboo.Phoenix',
                        'Elixir.Bamboo.SendgridAdapter',
                        'Elixir.Bamboo.SendgridAdapter.ApiError',
                        'Elixir.Bamboo.SentEmail',
                        'Elixir.Bamboo.SentEmail.DeliveriesError',
                        'Elixir.Bamboo.SentEmail.NoDeliveriesError',
                        'Elixir.Bamboo.TaskSupervisorStrategy',
                        'Elixir.Bamboo.Test','Elixir.Bamboo.TestAdapter',
                        'Elixir.Mix.Tasks.Bamboo.StartEmailPreview']},
              {applications,[kernel,stdlib,elixir,logger,httpoison,poison]},
              {mod,{'Elixir.Bamboo',[]}}]}.