def upgrade ta, td, a, d
  # Convert old single backend to new backend list
  old_volume = a['volume']
  a['volume'] = []
  backend_driver = old_volume['volume_type']
  a['volume'] << {
    "backend_name" => "default",
    "backend_driver" => backend_driver,
    backend_driver => old_volume[backend_driver]
  }

  # Synchronize the defaults
  a['volume_defaults'] = ta['volume_defaults']

  # Disable Multi backend support on migration
  a['volume_defaults']['use_multi_backend'] = false

  return a, d
end


def downgrade ta, td, a, d
  # preserve first volume backend
  current_backend_driver = a['volume'][0]['backend_driver']
  current_volume = a['volume'][0][current_backend_driver]
  a['volume'] = a['volume_defaults']
  a['volume'][current_backend_driver] = current_volume
  # Rename backend_driver back to volume_type
  a['volume']['volume_type'] = current_backend_driver
  a['volume'].delete 'use_multi_backend'
  a.delete 'volume_defaults'

  return a, d
end
