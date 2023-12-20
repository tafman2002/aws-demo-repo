from codeguru_profiler_agent import with_lambda_profiler


@with_lambda_profiler(profiling_group_name="MyGroupName")
def handler(event, context):
    return "Hello World"