# import multiprocessing

bind = "0.0.0.0:8000"
# workers = multiprocessing.cpu_count() * 2 + 1
# workers = 2
# threads = 2
workers = 4
threads = 1
backlog = 4096
