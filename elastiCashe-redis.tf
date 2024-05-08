resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.redis_pg.name
  engine_version       = "6.x"
  port                 = 6379
  security_group_ids   = [aws_security_group.allow_redis.id]
}

resource "aws_elasticache_parameter_group" "redis_pg" {
  name   = "roboshop-${var.ENV}-redis_pg"
  family = "redis6.x"
}

# Aws subnet group for group if subnets

resource "aws_elasticache_subnet_group" "redis" {
  name       = "roboshop-${var.ENV}-redis_gd_grp"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID
}