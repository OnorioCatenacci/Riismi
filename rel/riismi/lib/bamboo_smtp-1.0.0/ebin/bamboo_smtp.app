{application,bamboo_smtp,
             [{registered,[]},
              {description,"A Bamboo adapter for SMTP"},
              {vsn,"1.0.0"},
              {modules,['Elixir.Bamboo.SMTPAdapter',
                        'Elixir.Bamboo.SMTPAdapter.SMTPError']},
              {applications,[kernel,stdlib,elixir,gen_smtp,logger,bamboo]}]}.