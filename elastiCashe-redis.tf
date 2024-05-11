resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = var.REDIS_ENGINE
  node_type            = var.REDIS_NOTE_TYPE
  num_cache_nodes      = var.REDIS_CASHE_NODE
  parameter_group_name = aws_elasticache_parameter_group.redis_pg.name
  engine_version       = var.REDIS_ENGINE_VERSION
  port                 = var.REDIS_PORT
  security_group_ids   = [aws_security_group.allow_redis.id]
  subnet_group_name    = aws_elasticache_subnet_group.redis.name 
}

resource "aws_elasticache_parameter_group" "redis_pg" {
  name   = "roboshop-${var.ENV}-redis-pg"
  family = var.REDIS_FAMILY
}

# Aws subnet group for group if subnets

resource "aws_elasticache_subnet_group" "redis" {
  name       = "roboshop-${var.ENV}-redis-subnetgroup"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID
}