key "" {
	policy = "read"
}

key "/foo" {	
	policy = "write"
}

key "/foo/bar" {
	policy = "deny"
}

