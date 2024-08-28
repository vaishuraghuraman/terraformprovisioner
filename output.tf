output "instance_ssh_key"{

    value ="${abspath(path.root)}//ssh_key"
    depends_on = [ tls_private_key.ssh ]
}