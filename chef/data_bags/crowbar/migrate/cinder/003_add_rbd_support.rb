def upgrade ta, td, a, d
  a["volume"]["rbd"] = {}
  a["volume"]["rbd"].delete("secret_uuid")
  a["volume"]["rbd"]["pool"] = 'volumes'
  a["volume"]["rbd"]["user"] = 'volumes'
  return a, d
end


def downgrade ta, td, a, d
  a["volume"].delete("rbd")
  return a, d
end
