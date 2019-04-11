public DaemonSample(Vertx vertx) {

		System.out.println("######### Contruct DaemonNotify : " + Thread.currentThread().getName() + " ########");
		int i = 0;

		while (true) {
			String resStr = null;

			if (i > 0) {
				List<String> res_article_mst = RedisDaemonClient.getValueFromStore(RedisKeyStore.MSG_NOTIFY.getMaster(), 10);

				if (res_article_mst != null && res_article_mst.size() > 0) {
					resStr = res_article_mst.get(1);
				}

			} else {
				resStr = RedisDaemonClient.getValueFromStoreD(RedisKeyStore.MSG_NOTIFY.getMaster());
			}

			if (resStr != null && !resStr.equals("")) {
				System.out.println("[ DaemonNotify : " + Thread.currentThread().getName() + "]");
				System.out.println(resStr);

				try {

					JsonObject msg = new JsonObject(resStr);

					long now = System.currentTimeMillis();

					switch (msg.getString("action", "")) {
					case "":
						if (msg.containsKey("target")) {
							initNotifyAction(msg);
						}
						break;
					case "push-event":
						pushEvent(msg);
						break;
					case "push-usrid":
						pushNotifyUsrid(msg);
						break;
					case "push-system":
						// TODO SYSTEM NOTIFY
						break;
					}

				} catch (Exception e) {
					e.printStackTrace();
				}

				i = 0;
			} else {
				System.out.println("[ daemon DaemonNotify " + Thread.currentThread().getName() + " is alive now : "+ new Date() + "]");
				i++;
			}
		}

	}
